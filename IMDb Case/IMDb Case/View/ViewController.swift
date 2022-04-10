//
//  ViewController.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 8.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var upcomingTableView: UITableView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    
    private let movieService: GetMovieProtocol = MovieService()
    private let upcomingTableViewData: UpcomingTableView = UpcomingTableView()
    
    private let nowPlayingCollectionViewData: NowPlayingCollectionView = NowPlayingCollectionView()
    
    private let refreshControl = UIRefreshControl()

    var timer: Timer?
    var sliderCount = 0
    var currentIndex = 0
    var page = 1
    var isPageRefreshing: Bool = false
    
    var tableViewMovieArray: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initDelegate()
        self.initService(page: nil)
        self.setupSlider()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Auxilary Methods
extension ViewController {
    private func initDelegate() {
        registerTableViewCells()
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = upcomingTableViewData
        upcomingTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        
        registerCollectionViewCells()
        nowPlayingCollectionView.delegate = nowPlayingCollectionViewData
        nowPlayingCollectionView.dataSource = nowPlayingCollectionViewData
        nowPlayingCollectionViewData.delegate = self
    }
    
    private func initService(page: Int?) {
        movieService.getMovies(moviePath: MoviePath.Upcoming, page: page) { [weak self] response in
            if page == nil {
                self?.self.tableViewMovieArray.removeAll()
            }
            self?.self.tableViewMovieArray = (self?.self.tableViewMovieArray ?? []) + (response.results ?? [])
            self?.upcomingTableViewData.update(items: self?.self.tableViewMovieArray ?? [])
            self?.upcomingTableView.reloadData()
            if self?.self.isPageRefreshing ?? false {
                self?.self.isPageRefreshing = false
            }
        } onFailure: { errorString in
            debugPrint(errorString as Any)
        }
        
        movieService.getMovies(moviePath: MoviePath.NowPlaying, page: nil) { [weak self] response in
            self?.nowPlayingCollectionViewData.update(items: response.results ?? [])
            self?.nowPlayingCollectionView.reloadData()
            self?.self.sliderCount = response.results?.count ?? 0
        } onFailure: { errorString in
            debugPrint(errorString as Any)
        }
        self.refreshControl.endRefreshing()
    }
    
    private func setupSlider() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToImage), userInfo: nil, repeats: true)
    }
    
    private func registerTableViewCells() {
        let upcomingTableViewCell = UINib(nibName: "UpcomingTableViewCell",
                                  bundle: nil)
        self.upcomingTableView.register(upcomingTableViewCell,
                                forCellReuseIdentifier: "UpcomingTableViewCell")
    }
    
    private func registerCollectionViewCells() {
        self.nowPlayingCollectionView.register(UINib(nibName: "NowPlayingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingCollectionViewCell")
    }
}

// MARK: - Objc Methods
extension ViewController {
    @objc func slideToImage() {
        if currentIndex < sliderCount - 1 {
            currentIndex = currentIndex + 1
        } else {
            currentIndex = 0
        }
        
        nowPlayingCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
    }
    
    @objc func refreshPage() {
        self.initService(page: nil)
        self.currentIndex = 0
        self.page = 1
        nowPlayingCollectionView.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: .right, animated: true)
    }
}

// MARK: - Protocols
extension ViewController: NowPlayingCollectionViewOutput {
    func onSelected(movie: Movie) {
        let detailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        detailVC?.movieId = movie.id
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
}

// MARK: - TableView Delegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        detailVC?.movieId = tableViewMovieArray[indexPath.row].id
        self.navigationController?.pushViewController(detailVC!, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if pos > (upcomingTableView.contentSize.height + 100 - scrollView.frame.size.height) {
            if self.tableViewMovieArray.count <= 0 { return }
            if !isPageRefreshing {
                self.isPageRefreshing = true
                self.page = page + 1
                self.initService(page: page)
            }
        }
    }
}

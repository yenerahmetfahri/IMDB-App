//
//  ViewController.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 8.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var upcomingTableView: UITableView!
    
    private let movieService: GetMovieProtocol = MovieService()
    private let upcomingTableViewData: UpcomingTableView = UpcomingTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initDelegate()
        self.initService()
    }
    
    private func initDelegate() {
        upcomingTableView.delegate = upcomingTableViewData
        upcomingTableView.dataSource = upcomingTableViewData
        upcomingTableViewData.delegate = self
    }
    
    private func initService() {
        movieService.getMovies(moviePath: MoviePath.Upcoming) { [weak self] response in
            self?.upcomingTableViewData.update(items: response.results ?? [])
            self?.upcomingTableView.reloadData()
        } onFailure: { errorString in
            print(errorString as Any)
        }
    }
}

extension ViewController: UpcomingTableViewOutput {
    func onSelected(movie: Movie) {
        print(movie.title as Any)
    }
}

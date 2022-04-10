//
//  DetailViewController.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 9.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    
    private let movieService: GetMovieProtocol = MovieService()
    var movieId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initService()
    }
    
    private func initService() {
        movieService.getMovieDetail(movieId: "/\(movieId ?? 0)") { [weak self] (response) in
            DispatchQueue.main.async {
                self?.self.title = response.title
                self?.self.movieDate.text = response.releaseDate?.getDateParseFormat()
                self?.self.movieTitle.text = response.title
                self?.self.movieOverView.text = response.overview
                self?.self.movieImageView.kf.setImage(with: response.posterPath?.getOriginalPosterUrl())
                if let voteAverage = response.voteAverage {
                    self?.self.movieRate.text = "\(voteAverage)"
                }
            }
            
            
        } onFailure: { errorString in
            debugPrint(errorString as Any)
        }

    }
}

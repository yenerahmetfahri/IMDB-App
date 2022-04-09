//
//  MovieService.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 9.04.2022.
//

import Alamofire

protocol GetMovieProtocol {
    func getMovies(moviePath: MoviePath, onSuccess: @escaping (MoviesModel) -> Void, onFailure: @escaping (String?) -> Void)
}

enum MoviePath: String {
    case NowPlaying = "/now_playing"
    case Upcoming = "/upcoming"
}

extension MoviePath {
    func withBaseUrl() -> String {
        return "https://api.themoviedb.org/3/movie\(self.rawValue)?api_key=3be0e48fe01d3b9d6da1a938c12dc748"
    }
}

struct MovieService: GetMovieProtocol {
    func getMovies(moviePath: MoviePath, onSuccess: @escaping (MoviesModel) -> Void, onFailure: @escaping (String?) -> Void) {
        AF.request(moviePath.withBaseUrl(), method: .get).validate().responseDecodable(of: MoviesModel.self) {
            (response) in
            guard let data = response.value else {
                onFailure(response.debugDescription)
                return
            }
            onSuccess(data)
        }
    }
    
}

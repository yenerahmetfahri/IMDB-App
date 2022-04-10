//
//  MovieService.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 9.04.2022.
//

import Alamofire

protocol GetMovieProtocol {
    func getMovies(moviePath: MoviePath, page: Int?, onSuccess: @escaping (MoviesModel) -> Void, onFailure: @escaping (String?) -> Void)
    func getMovieDetail(movieId: String, onSuccess: @escaping (MovieDetailModel) -> Void, onFailure: @escaping (String?) -> Void)
}

struct MovieService: GetMovieProtocol {
    func getMovies(moviePath: MoviePath, page: Int?, onSuccess: @escaping (MoviesModel) -> Void, onFailure: @escaping (String?) -> Void) {
        var url = moviePath.withBaseUrl()
        if let page = page {
            url = url + "&page=\(page)"
        }
        AF.request(url, method: .get).validate().responseDecodable(of: MoviesModel.self) {
            (response) in
            guard let data = response.value else {
                onFailure(response.debugDescription)
                return
            }
            onSuccess(data)
        }
    }
    
    func getMovieDetail(movieId: String, onSuccess: @escaping (MovieDetailModel) -> Void, onFailure: @escaping (String?) -> Void) {
        let url = movieId.getMovieDetailURL()
        AF.request(url, method: .get).validate().responseDecodable(of: MovieDetailModel.self) {
            (response) in
            guard let data = response.value else {
                onFailure(response.debugDescription)
                return
            }
            onSuccess(data)
        }
    }
}

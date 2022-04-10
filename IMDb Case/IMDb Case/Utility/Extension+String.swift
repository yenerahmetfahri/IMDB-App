//
//  Extension+String.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 9.04.2022.
//

import Foundation

extension String {
    func getMiniPosterUrl() -> URL {
        let urlString = "https://image.tmdb.org/t/p/w500\(self)"
        return URL(string: urlString)!
    }
    
    func getOriginalPosterUrl() -> URL {
        let urlString = "https://image.tmdb.org/t/p/original\(self)"
        return URL(string: urlString)!
    }
    
    func getDateParseFormat() -> String {
        var date: String = ""
        
        let dateArray = self.components(separatedBy: "-")
        date = "\(dateArray[2]).\(dateArray[1]).\(dateArray[0])"
        
        return date
    }
    
    func getMovieDetailURL() -> URL {
        return URL(string: "https://api.themoviedb.org/3/movie\(self)?api_key=3be0e48fe01d3b9d6da1a938c12dc748&language=en-US")!
    }
}

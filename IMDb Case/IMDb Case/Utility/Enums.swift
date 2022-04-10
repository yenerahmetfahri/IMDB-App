//
//  Enums.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 9.04.2022.
//

import Foundation

enum MoviePath: String {
    case NowPlaying = "/now_playing"
    case Upcoming = "/upcoming"
}

extension MoviePath {
    func withBaseUrl() -> String {
        return "https://api.themoviedb.org/3/movie\(self.rawValue)?api_key=3be0e48fe01d3b9d6da1a938c12dc748&language=en-US"
    }
}

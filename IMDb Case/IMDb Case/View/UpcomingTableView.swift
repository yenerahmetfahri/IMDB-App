//
//  UpcomingTableView.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 9.04.2022.
//

import UIKit
import Kingfisher

protocol UpcomingTableViewProtocol {
    func update(items: [Movie])
}

final class UpcomingTableView: NSObject, UITableViewDataSource {
    
    private lazy var items: [Movie] = []
    
    var currentPage : Int = 0
    var isLoadingList : Bool = false

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell") as? UpcomingTableViewCell {
            cell.movieTitle.text = items[indexPath.row].title
            cell.movieDesc.text = items[indexPath.row].overview
            cell.movieDate.text = items[indexPath.row].releaseDate?.getDateParseFormat()
            cell.movieImage.kf.setImage(with: items[indexPath.row].posterPath?.getMiniPosterUrl())
            return cell
        }
        
        return UITableViewCell()
    }
}

extension UpcomingTableView: UpcomingTableViewProtocol {
    func update(items: [Movie]) {
        self.items = items
    }
}

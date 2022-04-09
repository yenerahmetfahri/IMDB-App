//
//  UpcomingTableView.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 9.04.2022.
//

import UIKit

protocol UpcomingTableViewProtocol {
    func update(items: [Movie])
}

protocol UpcomingTableViewOutput: class {
    func onSelected(movie: Movie)
}

final class UpcomingTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    private lazy var items: [Movie] = []

    weak var delegate: UpcomingTableViewOutput?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].originalTitle
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(movie: items[indexPath.row])
    }
}

extension UpcomingTableView: UpcomingTableViewProtocol {
    func update(items: [Movie]) {
        self.items = items
    }
}

//
//  UpcomingTableViewCell.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 9.04.2022.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var movieDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

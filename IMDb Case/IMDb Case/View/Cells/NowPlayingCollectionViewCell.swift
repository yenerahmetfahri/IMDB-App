//
//  NowPlayingCollectionViewCell.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 10.04.2022.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

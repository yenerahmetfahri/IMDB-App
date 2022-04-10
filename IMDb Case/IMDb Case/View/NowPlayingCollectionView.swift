//
//  NowPlayingCollectionView.swift
//  IMDb Case
//
//  Created by ahmetfahriyener on 9.04.2022.
//

import Foundation
import UIKit

protocol NowPlayingCollectionViewProtocol {
    func update(items: [Movie])
}

protocol NowPlayingCollectionViewOutput: class {
    func onSelected(movie: Movie)
}

final class NowPlayingCollectionView: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var items: [Movie] = []

    weak var delegate: NowPlayingCollectionViewOutput?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCollectionViewCell", for: indexPath) as? NowPlayingCollectionViewCell {
            cell.titleLabel.text = items[indexPath.row].title
            cell.descLabel.text = items[indexPath.row].overview
            cell.image.kf.setImage(with: items[indexPath.row].posterPath?.getMiniPosterUrl())
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onSelected(movie: items[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


extension NowPlayingCollectionView: NowPlayingCollectionViewProtocol {
    func update(items: [Movie]) {
        self.items = items
    }
}

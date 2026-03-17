//
//  CapturedPieceCell.swift
//  Chess
//
//  Created by Philips Jose on 18/02/26.
//

import UIKit

class CapturedPieceCell: UICollectionViewCell {
    
    @IBOutlet private weak var chessPieceCount: UILabel!
    @IBOutlet private weak var chessPieceImageView: UIImageView!
    
    
    public func configure(with image: UIImage? = nil, and count: Int = 0) {
        chessPieceImageView?.image = image
        chessPieceCount?.text = "\(count)"
    }

}

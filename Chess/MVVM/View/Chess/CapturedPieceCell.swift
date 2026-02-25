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
    
    
    public func configure(with image: UIImage? = nil) {
        chessPieceImageView?.image = image
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

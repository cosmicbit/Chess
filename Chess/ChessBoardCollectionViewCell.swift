//
//  ChessBoardCollectionViewCell.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit

class ChessBoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var chessPieceImageView: UIImageView!
    
    var chessBoardCell: ChessBoardCell?
    
    func configure(cell: ChessBoardCell) {
        self.chessBoardCell = cell
        assignImage()
    }
    
    private func assignImage() {
        
        chessPieceImageView?.image = chessBoardCell?.piece?.asset
    }
}

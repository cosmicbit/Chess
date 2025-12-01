//
//  ChessBoardCollectionViewCell.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit

class ChessBoardCollectionViewCell: UICollectionViewCell {
    
    static let id = "ChessBoardCollectionViewCell"
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var chessPieceImageView: UIImageView!
    
    var chessBoardCell: ChessBoardCell?
    
    func configure(cell: ChessBoardCell) {
        self.chessBoardCell = cell
        setupUI()
    }
    
    private func setupUI() {
        
        chessPieceImageView?.image = chessBoardCell?.piece?.asset
        self.backgroundColor = chessBoardCell?.currentColor.uiColor
    }
}

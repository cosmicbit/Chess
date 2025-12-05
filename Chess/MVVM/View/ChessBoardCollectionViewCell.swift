//
//  ChessBoardCollectionViewCell.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit

class ChessBoardCollectionViewCell: UICollectionViewCell {
    
    static let id = Constants.collectionViewCellID
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var chessPieceImageView: UIImageView!
    
    var chessBoardCell: ChessBoardCell?
    
    func configure(cell: ChessBoardCell) {
        self.chessBoardCell = cell
        setupUI()
    }
    
    private func setupUI() {
        guard let cell = chessBoardCell else { return }
        chessPieceImageView?.image = cell.piece?.asset
        self.backgroundImageView?.image = cell.currentColor == cell.defaultColor ? cell.currentColor.woodImage : nil
        
        switch cell.currectState {
        case .selected:
            self.stateImageView?.image = UIImage.cellSelected
        case .highlighted:
            self.stateImageView?.image = UIImage.cellHighlighted
        case .vulnerable:
            self.stateImageView?.image = UIImage.cellVulnerable
        case .check:
            self.stateImageView?.image = UIImage.cellCheck
        default:
            self.stateImageView?.image = nil
        }
    }
}

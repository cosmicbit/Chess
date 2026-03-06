//
//  ChessBoardCollectionViewCell.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit

class ChessBoardCollectionViewCell: UICollectionViewCell {
    
    static let id = Constants.chessBoardCellID
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var chessPieceImageView: UIImageView!
    
    private(set) var chessBoardCell: ChessBoardCell?
    private(set) var chessPiece: ChessPiece?
    
    func configure(cell: ChessBoardCell, piece: ChessPiece? = nil, at indexPath: IndexPath = IndexPath(item: 0, section: 0)) {
        self.chessBoardCell = cell
        self.chessPiece = piece
        self.setupUI(with: indexPath)
    }
    
    private func setupUI(with indexPath: IndexPath = IndexPath(item: 0, section: 0)) {
        self.idLabel?.text = "\(indexPath.item)"
        guard let cell = self.chessBoardCell else { return }
        self.chessPieceImageView?.isHidden = false
        self.chessPieceImageView?.image = self.chessPiece?.asset
        self.backgroundImageView?.image = cell.currentColor == cell.defaultColor ? cell.currentColor.woodImage : nil
        self.stateImageView?.image = cell.currectState.asset
    }
}

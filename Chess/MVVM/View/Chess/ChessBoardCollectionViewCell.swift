//
//  ChessBoardCollectionViewCell.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit

class ChessBoardCollectionViewCell: UICollectionViewCell {
    
    static let id = Constants.chessBoardCellID
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var chessPieceImageView: UIImageView!
    
    private(set) var chessBoardCell: ChessBoardCell?
    private(set) var chessPiece: ChessPiece?
    
    func configure(cell: ChessBoardCell, piece: ChessPiece? = nil) {
        self.chessBoardCell = cell
        self.chessPiece = piece
        self.setupUI()
    }
    
    public func shatterPiece(completion: @escaping () -> Void = {}) {
        ShatterAnimator.massiveShatter(view: chessPieceImageView)
    }
    
    private func setupUI() {
        guard let cell = self.chessBoardCell else { return }
        self.chessPieceImageView?.image = self.chessPiece?.asset
        self.backgroundImageView?.image = cell.currentColor == cell.defaultColor ? cell.currentColor.woodImage : nil
        self.stateImageView?.image = cell.currectState.asset
    }
}

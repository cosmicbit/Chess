//
//  ChessViewModel.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//
import UIKit

protocol ChessViewModelDelegate: AnyObject {
    func viewModelDidChangeBoard(_ viewModel: ChessViewModel)
}

class ChessViewModel {
    
    private(set) var mode = PlayerMode.passAndPlay
    private(set) var board = ChessBoard()
    private(set) var lastTappedLocation: ChessBoardLocation?
    
    public weak var delegate: ChessViewModelDelegate?
    
    func setMode(mode: PlayerMode) {
        self.mode = mode
    }
    
    func getCell(for indexPath: IndexPath) -> ChessBoardCell {
        let rowIndex = indexPath.item / 8
        let columnIndex = indexPath.item % 8
        return self.board.cells[rowIndex][columnIndex]
    }
    
    func getPiece(for indexPath: IndexPath) -> ChessPiece? {
        let cell = self.getCell(for: indexPath)
        return self.board.piece(at: cell.location)
    }
    
    func getPiece(in cell: ChessBoardCell) -> ChessPiece? {
        return self.board.piece(at: cell.location)
    }
    
    func getIndexPath(for location: ChessBoardLocation) -> IndexPath {
        let item = location.row * 8 + location.column
        return IndexPath(item: item, section: 0)
    }
 
    func getCellSize(for collectionViewBounds: CGRect) -> CGSize{
        let cellSpacing: CGFloat = 0.5
        let marginSpacing: CGFloat = 0
        let numberOfCellsInARow: CGFloat = 8
        let totalHorizontalSpacing = (marginSpacing * 2) + (cellSpacing * (numberOfCellsInARow - 1))
        let widthAvailableForCells = collectionViewBounds.width - totalHorizontalSpacing
        let cellWidth = widthAvailableForCells / numberOfCellsInARow
        guard cellWidth > 0 else {
            return .zero
        }
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func highlightCells(for moves: [ChessMove]) {
        moves.forEach {
            let state: ChessBoardCellState = $0.isAttacking ? .vulnerable : .highlighted
            self.board.changeCellState(at: $0.endLocation, with: state)
        }
        self.delegate?.viewModelDidChangeBoard(self)
    }
    
    func resetAll() {
        print("Reseting Board.....")
        self.board = ChessBoard()
        self.lastTappedLocation = nil
        self.delegate?.viewModelDidChangeBoard(self)
    }
    
    func didTapOnCell(_ currentTappedLocation: ChessBoardLocation) {
        
        // 1. If we tap a piece of the CURRENT player, always treat it as a "Selection"
        if let piece = self.board.piece(at: currentTappedLocation), piece.color == board.gameState.currentPlayer {
            self.board.resetCellColors()
            self.board.changeCellState(at: currentTappedLocation, with: .selected)
            
            let legalMoves = self.board.getLegalMoves(for: piece)
            self.highlightCells(for: legalMoves)
            self.lastTappedLocation = currentTappedLocation
            return
        }
        
        // 2. If we already have a selection and tap an empty square or enemy piece, try to move
        if let startLocation = lastTappedLocation {
            self.board.resetCellColors()
            let result = self.board.attemptMove(from: startLocation, to: currentTappedLocation)
            
            switch result {
            case .success:
                self.delegate?.viewModelDidChangeBoard(self)
            case .failure(let reason):
                print("Move Failed: \(reason)")
                self.delegate?.viewModelDidChangeBoard(self)
            }
            self.lastTappedLocation = nil
        }
    }
    
}

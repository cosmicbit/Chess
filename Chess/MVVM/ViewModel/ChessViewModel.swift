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
    private(set) var lastTappedCell: ChessBoardCell?
    
    public weak var delegate: ChessViewModelDelegate?
    
    func getCell(for indexPath: IndexPath) -> ChessBoardCell {
        let rowIndex = indexPath.item / 8
        let columnIndex = indexPath.item % 8
        return board.cells[rowIndex][columnIndex]
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
            board.changeCellState(at: $0.endLocation, with: state)
        }
        delegate?.viewModelDidChangeBoard(self)
    }
    
    func resetAll() {
        print("Reseting Board.....")
        board = ChessBoard()
        lastTappedCell = nil
        delegate?.viewModelDidChangeBoard(self)
    }
    
    func didTapOnCell(_ currentTappedCell: ChessBoardCell) {
        let currentCellLocation = currentTappedCell.location

        // 1. Handle Selection (First Tap or Tapping a new piece)
        if lastTappedCell == nil || lastTappedCell?.piece?.color == currentTappedCell.piece?.color {
            board.resetCellColors()
            
            if let piece = currentTappedCell.piece {
                if board.gameState.currentPlayer == piece.color {
                    board.changeCellState(at: currentTappedCell.location, with: .selected)
                    let legalMoves = board.getLegalMoves(for: piece)
                    highlightCells(for: legalMoves)
                    lastTappedCell = currentTappedCell
                    return
                }
                return
            }
        }

        // 2. Handle Move Attempt (Second Tap on an empty or enemy cell)
        if let startCell = lastTappedCell {
            let startLocation = startCell.location
            board.resetCellColors()
            let result = board.attemptMove(from: startLocation, to: currentCellLocation)
            
            switch result {
            case .success(let move):
                break
            case .failure(let reason):
                print("Move Failed: \(reason)")
            }
            delegate?.viewModelDidChangeBoard(self)
            lastTappedCell = nil
        }
    }
    
}

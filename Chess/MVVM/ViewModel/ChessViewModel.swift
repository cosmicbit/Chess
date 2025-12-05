//
//  ChessViewModel.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//
import UIKit

class ChessViewModel {
    
    private(set) var board = ChessBoard()
    private(set) var lastTappedCell: ChessBoardCell?
    
    var reloadView: (() -> Void)?
    var updateUIForIndexPaths: ((_ indexPaths: [IndexPath], _ isAttacking: Bool) -> Void)?
    
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
    
    func updateUIForAllCells() {
        let indexPaths = board.cells.flatMap { rowCells in
            rowCells.map { cell in
                getIndexPath(for: cell.location)
            }
        }
        updateUIForIndexPaths?(indexPaths, false)
    }
    
    func colorCell(at location: ChessBoardLocation, with color: ChessBoardCellColor) {
        let i = location.row
        let j = location.column
        board.cells[i][j].currentColor = color
    }
    
    func highlightCells(for moves: [ChessMove]) {
        moves.forEach {
            let state: ChessBoardCellState = $0.isAttacking ? .vulnerable : .highlighted
            //board.changeCellColor(at: $0.endLocation, with: color)
            board.changeCellState(at: $0.endLocation, with: state)
        }
        reloadView?()
    }
    
    func resetAll() {
        print("Reseting Board.....")
        board = ChessBoard()
        lastTappedCell = nil
        reloadView?()
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
                let indexPaths = [move.startLocation, move.endLocation].map { getIndexPath(for: $0) }
            case .failure(let reason):
                print("Move Failed: \(reason)")
            }
            reloadView?()
            lastTappedCell = nil
        }
    }
    
}

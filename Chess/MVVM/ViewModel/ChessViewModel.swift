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
    
    var updateUI: (() -> Void)?
    
    func getCell(for indexPath: IndexPath) -> ChessBoardCell{
        let rowIndex = indexPath.item / 8
        let columnIndex = indexPath.item % 8
        return board.cells[rowIndex][columnIndex]
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
    
    func colorCell(at location: ChessBoardLocation, with color: ChessBoardCellColor) {
        let i = location.row
        let j = location.column
        board.cells[i][j].currentColor = color
    }
    
    func highlightCells(for moves: [ChessMove]) {
        moves.forEach {
            let color = $0.isAttacking ? ChessBoardCellColor.red : ChessBoardCellColor.yellow
            board.changeCellColor(at: $0.endLocation, with: color)
        }
    }
    
    func resetAll() {
        print("Reseting Board.....")
        board = ChessBoard()
        lastTappedCell = nil
        updateUI?()
    }
    
    func didTapOnCell(_ currentTappedCell: ChessBoardCell) {
        let currentCellLocation = currentTappedCell.location

        // 1. Handle Selection (First Tap or Tapping a new piece)
        if lastTappedCell == nil {
            board.resetCellColors()
            
            if let piece = currentTappedCell.piece {
                let legalMoves = board.getLegalMoves(for: piece)
                highlightCells(for: legalMoves)
                lastTappedCell = currentTappedCell
                updateUI?()
                return
            }
        }

        // 2. Handle Move Attempt (Second Tap on an empty or enemy cell)
        if let startCell = lastTappedCell {
            let startLocation = startCell.location
            
            // **DELEGATE CORE LOGIC TO THE BOARD**
            let result = board.attemptMove(from: startLocation, to: currentCellLocation)
            
            board.resetCellColors()
            
            switch result {
            case .success:
                break
            case .failure(let reason):
                print("Move Failed: \(reason)")
            }
            updateUI?()
            lastTappedCell = nil
        }
    }
    
}

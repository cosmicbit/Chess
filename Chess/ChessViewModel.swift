//
//  ChessViewModel.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//
import Combine
import UIKit

class ChessViewModel {
    
    @Published var board = ChessBoard()
    @Published private(set) var lastTappedCell: ChessBoardCell?
    
    private var shouldMovePiece: Bool = false
    
    func assignNewLastTappedCell(_ cell: ChessBoardCell) {
        lastTappedCell = cell
    }
    
    func makeLastTappedCellColorToDefault() {
        if let color = lastTappedCell?.defaultColor {
            lastTappedCell?.currentColor = color
        }
    }
    
    func emptyLastTappedCell() {
        lastTappedCell?.piece = nil
        lastTappedCell = nil
    }
    
    func changeLastTappedCellPieceLocation(to location: ChessBoardLocation) {
        lastTappedCell?.piece?.location = location
    }
    
    func seeAllMoves(of piece: ChessPiece?) {
        guard let piece = piece else { return }
        let locations = board.getLegalMoves(for: piece)
        for location in locations {
            let i = location.row
            let j = location.column
            board.cells[i][j].currentColor = .yellow
//            let cell = board.cells.first { $0.location == location}
//            cell?.currentColor = .yellow
        }
            
        
    }
    
    func resetBoardColors() {
        //board.cells.forEach { $0.currentColor = $0.defaultColor }
        for i in 0..<8 {
            for j in 0..<8 {
                let cell = board.cells[i][j]
                cell.currentColor = cell.defaultColor
            }
        }
    }
    
    func resetAll() {
        print("Reseting Board.....")
        board = ChessBoard()
        lastTappedCell = nil
        shouldMovePiece = false
    }
    
    func didTapOnCell(_ currentTappedCell: ChessBoardCell) {

        if let lastTappedCell = lastTappedCell {
            print("Last Tapped cell is at \(lastTappedCell.location.getLocationAsString())")
            
            if let currentTappedPiece = currentTappedCell.piece {
                // current tapped cell have a piece
                
                if let lastTappedPiece = lastTappedCell.piece {
                    // last tapped cell and current tapped cell have a piece
                    
                    print("Last: HAVE, Current: HAVE")
                    if lastTappedPiece.color == currentTappedPiece.color {
                        resetBoardColors()
                        seeAllMoves(of: currentTappedPiece)
                        shouldMovePiece = true
                        print("------Move To be made--------")
                    } else {
                        // this place will be used to cut down pieces
                        
                        
                        resetBoardColors()
                    }
                } else {
                    // last tapped cell donot have a piece but current tapped cell have a piece
                    
                    print("Last: NIL, Current: HAVE")
                    seeAllMoves(of: currentTappedPiece)
                    shouldMovePiece = true
                    print("------Move To be made------")
                }
            } else {
                // current tapped cell donot have a piece
                
                resetBoardColors()
                if let lastTappedPiece = lastTappedCell.piece, shouldMovePiece {
                    // last tapped cell have a piece but current tapped cell donot have a piece
                    
                    print("Last: HAVE, Current: NIL")
                    if lastTappedPiece.getAllMoves().contains(currentTappedCell.location) {
                        print("Valid Move")
                        currentTappedCell.piece = lastTappedPiece
                        currentTappedCell.piece?.location = currentTappedCell.location
                        lastTappedCell.piece = nil
                    } else {
                        print("Invalid Move")
                        resetBoardColors()
                    }
                    
                    shouldMovePiece = false
                    print("======Move Made======")
                } else {
                    // Both last tapped cell and current tapped cell donot have a piece
                    print("Last: NIL, Current: NIL")
                }
            }
        } else {
            print("Last tapped cell is nil")
            seeAllMoves(of: currentTappedCell.piece)
            shouldMovePiece = true
            print("------Move To be made--------")
        }
        
        assignNewLastTappedCell(currentTappedCell)
    }
    
}

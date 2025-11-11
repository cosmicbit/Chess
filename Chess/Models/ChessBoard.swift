//
//  ChessBoard.swift
//  Chess
//
//  Created by Philips Jose on 07/11/25.
//
import Foundation

class ChessBoard {
    var cells: [[ChessBoardCell]]
    var blackPieces: [ChessPiece]
    var whitePieces: [ChessPiece]
    var chessPieces: [ChessPiece]
    
    init() {
        self.blackPieces = ChessPiece.getBlackPieces()
        self.whitePieces = ChessPiece.getWhitePieces()
        self.chessPieces = blackPieces + whitePieces
        cells = []
        for i in 0..<8 {
            var row: [ChessBoardCell] = []
            for j in 0..<8 {
                let cell = ChessBoardCell(location: ChessBoardLocation(row: i, column: j)!)
                row.append(cell)
            }
            cells.append(row)
        }
        //cells = cells.sorted(by: { $0.location < $1.location })
        
        print("Chess Board is initialized with \(cells[0].count) cells.")
        chessPieces.forEach { piece in
            let i = piece.location.row
            let j = piece.location.column
            cells[i][j].piece = piece

        }
    }
    
    func snapshot() {
        print("--- Board Info: -----")
        print("Cell count: ", cells.count)
        print("Pieces Count:", chessPieces.count)
        for i in 0..<8 {
            for j in 0..<8 {
                print("\(cells[i][j].location.getLocationAsString()) has ", terminator: "")
                if let piece = cells[i][j].piece {
                    print("Piece = \(piece.color.rawValue) \(piece.type.rawValue)")
                } else {
                    print("Piece = Blank")
                }
            }
        }
    }
}

extension ChessBoard {
    func getLegalMoves(for piece: ChessPiece) -> [ChessBoardLocation] {
        let potentialMoves = piece.getAllMoves()
        var legalMoves: [ChessBoardLocation] = []
        
        for move in potentialMoves {
            if !doesConflictWithTeam(move: move, myColor: piece.color) {
                legalMoves.append(move)
            }
        }
        
        return legalMoves
    }
    
    private func doesConflictWithTeam(move: ChessBoardLocation, myColor: ChessPieceColor) -> Bool {
        let i = move.row
        let j = move.column
        if cells[i][j].piece?.color == myColor {
            return true
        } else {
            return false
        }
    }
    
    private func isSomePieceCoveringTheWayDiagonally(move: ChessBoardLocation) {
        
    }
}

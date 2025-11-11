//
//  ChessBoard.swift
//  Chess
//
//  Created by Philips Jose on 07/11/25.
//
import Foundation

class ChessBoard {
    var cells: [ChessBoardCell]
    var blackPieces: [ChessPiece]
    var whitePieces: [ChessPiece]
    var chessPieces: [ChessPiece]
    
    init() {
        self.blackPieces = ChessPiece.getBlackPieces()
        self.whitePieces = ChessPiece.getWhitePieces()
        self.chessPieces = blackPieces + whitePieces
        cells = []
        for i in 0..<8 {
            for j in 0..<8 {
                cells.append(ChessBoardCell(location: ChessBoardLocation(row: i, column: j)))
            }
        }
        cells = cells.sorted(by: { $0.location < $1.location })
        
        print("Chess Board is initialized with \(cells.count) cells.")
        chessPieces.forEach { piece in
            if let cell = cells.first(where: { cell in
                cell.location == piece.location
            }) {
                cell.piece = piece
            }
        }
    }
    
    func snapshot() {
        print("--- Board Info: -----")
        print("Cell count: ", cells.count)
        print("Pieces Count:", chessPieces.count)
        for cell in cells {
            
            print("\(cell.location.getLocationAsString()) has ", terminator: "")
            if let piece = cell.piece {
                print("Piece = \(piece.color.rawValue) \(piece.type.rawValue)")
            } else {
                print("Piece = Blank")
            }
            
        }
    }
}

extension ChessBoard {
    func getLegalMoves(for piece: ChessPiece) -> [ChessBoardLocation] {
        let potentialMoves = piece.getAllMoves()
        var legalMoves: [ChessBoardLocation] = []
        
        switch piece.type {
        case .king:
            for move in potentialMoves {
                if !doesConflictWithTeam(move: move, myColor: piece.color) {
                    legalMoves.append(move)
                }
            }
        case .queen:
            for move in potentialMoves {
                if !doesConflictWithTeam(move: move, myColor: piece.color) {
                    legalMoves.append(move)
                }
            }
        case .bishop:
            for move in potentialMoves {
                if !doesConflictWithTeam(move: move, myColor: piece.color) {
                    if let cell = cells.first (where: { cell in cell.location == move }) {
                        if let otherPiece = cell.piece {
                            if abs(otherPiece.location.row - piece.location.row) == abs(otherPiece.location.column - piece.location.column) {
                                for index in potentialMoves.indices {
                                    if abs(potentialMoves[index].row - otherPiece.location.row) == abs(potentialMoves[index].column - otherPiece.location.column) {
                                        
                                    }
                                }
                            }
                        }
                    }
                    legalMoves.append(move)
                }
            }
        case .knight:
            for move in potentialMoves {
                if !doesConflictWithTeam(move: move, myColor: piece.color) {
                    legalMoves.append(move)
                }
            }
        case .rook:
            for move in potentialMoves {
                if !doesConflictWithTeam(move: move, myColor: piece.color) {
                    legalMoves.append(move)
                }
            }
        case .pawn:
            for move in potentialMoves {
                if !doesConflictWithTeam(move: move, myColor: piece.color) {
                    legalMoves.append(move)
                }
            }
        }
        
        return legalMoves
    }
    
    private func doesConflictWithTeam(move: ChessBoardLocation, myColor: ChessPieceColor) -> Bool {
        if let cell = cells.first (where: { cell in cell.location == move }) {
            if cell.piece?.color == myColor {
                return true
            }
            else {
                return false
            }
        } else {
            return false
        }
    }
    
    private func isSomePieceCoveringTheWayDiagonally(move: ChessBoardLocation) {
        
    }
}

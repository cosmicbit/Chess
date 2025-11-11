//
//  ChessPiece.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit
import Foundation

class ChessPiece {
    let id = UUID()
    let color: ChessPieceColor
    let type: ChessPieceType
    var location: ChessBoardLocation
    
    init(color: ChessPieceColor, type: ChessPieceType, location: ChessBoardLocation) {
        self.color = color
        self.type = type
        self.location = location
    }
    
    static func getBlackPieces() -> [ChessPiece] {
        return [
            ChessPiece(color: .black, type: .rook,   location: ChessBoardLocation(row: 0, column: 0)!),
            ChessPiece(color: .black, type: .rook,   location: ChessBoardLocation(row: 0, column: 7)!),

            ChessPiece(color: .black, type: .knight, location: ChessBoardLocation(row: 0, column: 1)!),
            ChessPiece(color: .black, type: .knight, location: ChessBoardLocation(row: 0, column: 6)!),
            ChessPiece(color: .black, type: .bishop, location: ChessBoardLocation(row: 0, column: 2)!),
            ChessPiece(color: .black, type: .bishop, location: ChessBoardLocation(row: 0, column: 5)!),

            ChessPiece(color: .black, type: .king,   location: ChessBoardLocation(row: 0, column: 3)!),
            ChessPiece(color: .black, type: .queen,  location: ChessBoardLocation(row: 0, column: 4)!),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 0)!),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 1)!),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 2)!),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 3)!),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 4)!),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 5)!),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 6)!),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 7)!),
        ]
    }
    
    static func getWhitePieces() -> [ChessPiece] {
        return [
     
            ChessPiece(color: .white, type: .rook,   location: ChessBoardLocation(row: 7, column: 0)!),
            ChessPiece(color: .white, type: .rook,   location: ChessBoardLocation(row: 7, column: 7)!),
            ChessPiece(color: .white, type: .knight, location: ChessBoardLocation(row: 7, column: 1)!),
            ChessPiece(color: .white, type: .knight, location: ChessBoardLocation(row: 7, column: 6)!),
            ChessPiece(color: .white, type: .bishop, location: ChessBoardLocation(row: 7, column: 2)!),
            ChessPiece(color: .white, type: .bishop, location: ChessBoardLocation(row: 7, column: 5)!),
            ChessPiece(color: .white, type: .king,   location: ChessBoardLocation(row: 7, column: 3)!),
            ChessPiece(color: .white, type: .queen,  location: ChessBoardLocation(row: 7, column: 4)!),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 0)!),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 1)!),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 2)!),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 3)!),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 4)!),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 5)!),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 6)!),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 7)!),
        ]
    }
}

extension ChessPiece {
    var asset: UIImage {
        self.type.image(color: self.color)
    }
    
    func getAllMoves() -> [ChessMove] {
        let location = self.location
        var moves: [ChessMove] = []
        switch self.type {
        case .king:
            
            var locations: [ChessBoardLocation?] = []
            locations = [
                ChessBoardLocation(row: location.row + 1, column: location.column),
                ChessBoardLocation(row: location.row + 1, column: location.column + 1),
                ChessBoardLocation(row: location.row + 1, column: location.column - 1),
                ChessBoardLocation(row: location.row,     column: location.column + 1),
                ChessBoardLocation(row: location.row,     column: location.column - 1),
                ChessBoardLocation(row: location.row - 1, column: location.column),
                ChessBoardLocation(row: location.row - 1, column: location.column + 1),
                ChessBoardLocation(row: location.row - 1, column: location.column - 1),
            ]
            locations.forEach { loc in
                if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                }
            }
            return moves
        case .queen:
            var locations: [ChessBoardLocation?] = []
            
            for i in 1..<8 {
                locations.append(ChessBoardLocation(row: location.row + i, column: location.column))
                locations.append(ChessBoardLocation(row: location.row + i, column: location.column + i))
                locations.append(ChessBoardLocation(row: location.row, column: location.column + i))
                locations.append(ChessBoardLocation(row: location.row - i, column: location.column + i))
                locations.append(ChessBoardLocation(row: location.row - i, column: location.column))
                locations.append(ChessBoardLocation(row: location.row - i, column: location.column - i))
                locations.append(ChessBoardLocation(row: location.row, column: location.column - i))
                locations.append(ChessBoardLocation(row: location.row + i, column: location.column - i))
            }
            locations.forEach { loc in
                if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                }
            }
            return moves
        case .bishop:
            var locations: [ChessBoardLocation?] = []
            for i in 1..<8 {
                locations.append(ChessBoardLocation(row: location.row + i, column: location.column + i))
                locations.append(ChessBoardLocation(row: location.row - i, column: location.column - i))
                locations.append(ChessBoardLocation(row: location.row + i, column: location.column - i))
                locations.append(ChessBoardLocation(row: location.row - i, column: location.column + i))
            }
            locations.forEach { loc in
                if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                }
            }
            return moves
        case .knight:
            let locations = [
                ChessBoardLocation(row: location.row + 2, column: location.column + 1),
                ChessBoardLocation(row: location.row + 2, column: location.column - 1),
                ChessBoardLocation(row: location.row + 1, column: location.column + 2),
                ChessBoardLocation(row: location.row + 1, column: location.column - 2),
                ChessBoardLocation(row: location.row - 2, column: location.column + 1),
                ChessBoardLocation(row: location.row - 2, column: location.column - 1),
                ChessBoardLocation(row: location.row - 1, column: location.column + 2),
                ChessBoardLocation(row: location.row - 1, column: location.column - 2),
            ]
            locations.forEach { loc in
                if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                }
            }
            return moves
        case .rook:
            var locations: [ChessBoardLocation?] = []
            for i in 1..<8 {
                locations.append(ChessBoardLocation(row: location.row + i, column: location.column))
                locations.append(ChessBoardLocation(row: location.row, column: location.column + i))
                locations.append(ChessBoardLocation(row: location.row - i, column: location.column))
                locations.append(ChessBoardLocation(row: location.row, column: location.column - i))
            }
            locations.forEach { loc in
                if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                }
            }
            return moves
        case .pawn:
            switch self.color {
            case .white:
                let locations = [
                    ChessBoardLocation(row: location.row - 1, column: location.column - 1),
                    ChessBoardLocation(row: location.row - 1, column: location.column),
                    ChessBoardLocation(row: location.row - 2, column: location.column),
                    ChessBoardLocation(row: location.row - 1, column: location.column + 1),
                ]
                locations.forEach { loc in
                    if let loc = loc {
                        moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                    }
                }
                return moves
            case .black:
                let locations = [
                    ChessBoardLocation(row: location.row + 1, column: location.column - 1),
                    ChessBoardLocation(row: location.row + 1, column: location.column),
                    ChessBoardLocation(row: location.row + 2, column: location.column),
                    ChessBoardLocation(row: location.row + 1, column: location.column + 1),
                ]
                
                locations.forEach { loc in
                    if let loc = loc {
                        moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                    }
                }
                
                return moves
            }
        }
    }
}

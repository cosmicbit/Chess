//
//  ChessMove.swift
//  Chess
//
//  Created by Philips Jose on 11/11/25.
//

class ChessMove {
    let startLocation: ChessBoardLocation
    let endLocation: ChessBoardLocation
    let piece: ChessPiece
    
    init(startLocation: ChessBoardLocation, endLocation: ChessBoardLocation, piece: ChessPiece) {
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.piece = piece
    }
}

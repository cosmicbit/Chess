//
//  GameState.swift
//  Chess
//
//  Created by Philips Jose on 01/12/25.
//


struct GameState {
    // 1. Turn Management
    var currentPlayer: ChessPieceColor = .white

    // 2. Castling Rights (Crucial for legality)
    var canWhiteKingSideCastle: Bool = true  // e.g., e1-g1, or K-side
    var canWhiteQueenSideCastle: Bool = true // e.g., e1-c1, or Q-side
    var canBlackKingSideCastle: Bool = true
    var canBlackQueenSideCastle: Bool = true

    // 3. En Passant Target (Crucial for legality)
    // This is the square *behind* the pawn that moved two steps.
    var enPassantTargetLocation: ChessBoardLocation? = nil

    // 4. Draw/History Tracking
    var halfMoveClock: Int = 0 // Used for the 50-move draw rule (moves since last pawn advance/capture)
    var fullMoveNumber: Int = 1 // Increments after Black's move
    var moveHistory: [ChessMove] = []
    
    // You may also want to track unique board positions for three-fold repetition:
    // var positionHistory: Set<BoardHash> = [] 
}

extension GameState {
    mutating func togglePlayer() {
        currentPlayer = currentPlayer == .white ? .black : .white
    }
}

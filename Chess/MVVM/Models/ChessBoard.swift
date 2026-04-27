//
//  ChessBoard.swift
//  Chess
//
//  Created by Philips Jose on 07/11/25.
//
import Foundation

struct ChessBoard {
    var pieceMap = ChessPiece.loadPiecesFromFile(file: Constants.chessPieceDataFile) ?? [:]
    var gameState = GameState()
    var cells: [[ChessBoardCell]] = (0..<8).map { r in (0..<8).map { c in .init(location: .init(row: r, column: c)) } }
}


extension ChessBoard {
    
    mutating func resetCellColors() {
        for r in cells.indices {
            for c in cells[r].indices {
                cells[r][c].currectState = .none
            }
        }
    }
}

//MARK: - Helpers
extension ChessBoard {
    func piece(at loc: ChessBoardLocation) -> ChessPiece? { pieceMap[loc] }
    
    func loc(of piece: ChessPieceType, with color: ChessPieceColor) -> ChessBoardLocation? {
        pieceMap.first { $0.value.type == piece && $0.value.color == color }?.key
    }
    
    private func isOccupied(at loc: ChessBoardLocation) -> Bool { pieceMap.keys.contains(loc) }
    
    private func isInBounds(loc: ChessBoardLocation) -> Bool { (0..<8).contains(loc.row) && (0..<8).contains(loc.column) }
    
    private func willItMakeKingInCheck(_  move: ChessMove) -> Bool {
        // 1. Create a copy of the current board
        var tempBoard = self
        
        // 2. Simulate the move
        // Note: Use a simplified execution that doesn't trigger side effects like UI updates
        tempBoard.executeMove(move)
        
        // 3. Find the King's new position
        let kingColor = move.piece.color
        guard let kingLocation = tempBoard.pieceMap.first(where: {
            $1.type == .king && $1.color == kingColor
        })?.key else { return true } // Should never happen in valid chess

        // 4. Check if any enemy piece can move to the King's location
        let enemyColor = kingColor.otherColor
        for (loc, piece) in tempBoard.pieceMap where piece.color == enemyColor {
            // We only need pseudo-legal moves here to avoid infinite recursion
            let enemyMoves = tempBoard.getPseudoLegalMoves(for: piece, at: loc)
            if enemyMoves.contains(where: { $0.endLocation == kingLocation }) {
                return true
            }
        }
        
        return false
    }
    
    private func getKingPosition(color: ChessPieceColor) -> ChessBoardLocation {
        return loc(of: .king, with: color) ?? ChessBoardLocation(row: 0, column: 0)
    }
}

//MARK: - Move Generation
extension ChessBoard {
    
    func getLegalMoves(for piece: ChessPiece, at start: ChessBoardLocation) -> [ChessMove] {
        let moves = self.getPseudoLegalMoves(for: piece, at: start)
        
        return moves.filter { move in
            !willItMakeKingInCheck(move)
        }
    }
    
    private func getPseudoLegalMoves(for piece: ChessPiece, at loc: ChessBoardLocation) -> [ChessMove] {
        let directions = piece.getDirections()
        
        switch piece.type {
        case .king, .knight:
            return directions.compactMap { validate(piece, from: loc, dir: $0, dist: 1) }
            
        case .pawn:
            return getPawnMoves(for: piece, from: loc)
            
        case .queen, .bishop, .rook:
            return directions.flatMap { slide(piece, from: loc, dir: $0) }
        }
    }
    
    private func getPawnMoves(for piece: ChessPiece, from start: ChessBoardLocation) -> [ChessMove] {
        let directions = piece.getDirections()
        
        return directions.compactMap { dir -> ChessMove? in
            guard let move = validate(piece, from: start, dir: dir, dist: 1) else {
                return nil
            }
            let isTargetOccupied = isOccupied(at: move.endLocation)
            switch dir.key {
            case "U":
                return !isTargetOccupied ? move : nil
            case "UU":
                let singleStepDir = directions.first { $0.key == "U" }
                let pathBlocked = singleStepDir.map { isOccupied(at: start.offset(by: $0)) } ?? true
                return (!piece.hasMoved && !isTargetOccupied && !pathBlocked) ? move : nil
            case "UL", "UR":
                return (isTargetOccupied && move.isAttacking) ? move : nil
            default:
                return nil
            }
        }
    }
    
    private func validate(_ piece: ChessPiece, from start: ChessBoardLocation,
                          dir: Direction, dist: Int) -> ChessMove? {
        let target = start.offset(by: dir, distance: dist)
        guard isInBounds(loc: target) else { return nil }
        let move: ChessMove
        
        if let targetPiece = self.piece(at: target) {
            if targetPiece.color != piece.color {
                move = ChessMove(start: start, end: target, piece: piece, direction: dir, isAttacking: true, capturedPiece: targetPiece)
            } else {
                return nil
            }
        } else {
            move = ChessMove(start: start, end: target, piece: piece, direction: dir, isAttacking: false)
        }
        
        return move //self.willItMakeKingInCheck(move, board: self) ? nil : move
    }
    
    private func slide(_ piece: ChessPiece, from start: ChessBoardLocation, dir: Direction) -> [ChessMove] {
        var moves = [ChessMove]()
        for dist in 1...7 {
            guard let move = validate(piece, from: start, dir: dir, dist: dist) else { break }
            moves.append(move)
            if move.isAttacking { break }
        }
        return moves
    }
}

// MARK: - Move Execution
extension ChessBoard {
    mutating func attemptMove(from start: ChessBoardLocation,
                         to end: ChessBoardLocation) -> MoveResult {
        
        guard let pieceToMove = self.piece(at: start) else {
            return .failure(reason: .noPieceAtStart)
        }
        
        guard pieceToMove.color == gameState.currentPlayer else {
            return .failure(reason: .wrongTurn)
        }

        let legalMoves = self.getLegalMoves(for: pieceToMove, at: start)

        let validMove = legalMoves.first { $0.endLocation == end }
        
        guard let move = validMove else {
            return .failure(reason: .illegalMove)
        }

        self.executeMove(move)
        
        return .success(move: move)
    }
    
    mutating private func executeMove(_ move: ChessMove) {
        guard var piece = pieceMap.removeValue(forKey: move.startLocation) else { return }
        piece.hasMoved = true
        self.pieceMap[move.endLocation] = piece
        
        gameState.togglePlayer()
        gameState.isCheck = isKingInCheck(color: gameState.currentPlayer)
        gameState.moveHistory.append(move)
    }
    
    private func isKingInCheck(color: ChessPieceColor) -> Bool {
        // 1. Find the King
        guard let kingLocation = self.loc(of: .king, with: color) else {
            return false
        }
        
        // 2. Check if any opponent piece can move to that location
        let opponentColor = color.otherColor
        for (loc, piece) in pieceMap where piece.color == opponentColor {
            // Use pseudo-legal moves (no king-in-check filtering) to avoid recursion
            let possibleMoves = getPseudoLegalMoves(for: piece, at: loc)
            if possibleMoves.contains(where: { $0.endLocation == kingLocation }) {
                return true
            }
        }
        return false
    }
}

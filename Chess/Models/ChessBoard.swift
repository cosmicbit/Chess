//
//  ChessBoard.swift
//  Chess
//
//  Created by Philips Jose on 07/11/25.
//
import Foundation

class ChessBoard {
    let numberOfCells = 64
    let numberOfPieces = 32
    let numberOfPawns = 16
    let numberOfRooks = 4
    let numberOfKnights = 4
    let numberOfBishops = 4
    let numberOfQueens = 2
    let numberOfKings = 2
    let numberCellsColors = 2
    let numberOfPieceColors = 2
    let rowRange = 0..<8
    let columnRange = 0..<8
    
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
                let cell = ChessBoardCell(location: ChessBoardLocation(row: i, column: j))
                row.append(cell)
            }
            cells.append(row)
        }
        
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
    private typealias PossibleMove = (move: ChessMove, isAttack: Bool)
    
    func getLegalMoves(for piece: ChessPiece) -> [ChessMove] {
        var legalMoves = [ChessMove]()
        
        switch piece.type {
            
        case .king, .knight:
            legalMoves = piece.getDirections().compactMap { direction -> ChessMove? in
                return getValidMove(for: piece, rowDelta: direction.rowChange, colDelta: direction.colChange, distance: 1)
            }
            
        case .queen, .bishop, .rook:
            legalMoves = piece.getDirections().flatMap { direction in
                return generateMovesInDirection(for: piece, rowDelta: direction.rowChange, colDelta: direction.colChange)
            }
            
        case .pawn:
            for move in piece.getAllMoves() {
                let row = move.endLocation.row
                let column = move.endLocation.column
                if isThisCellValidToMove(row: row, column: column) {
                    legalMoves.append(ChessMove(startLocation: piece.location, endLocation: move.endLocation, piece: piece))
                }
            }
        }
        
        return legalMoves
    }
    
    private func getValidMove(for piece: ChessPiece,
                              rowDelta: Int,
                              colDelta: Int,
                              distance: Int) -> ChessMove? {
        let location = piece.location
        let targetRow = location.row + rowDelta * distance
        let targetColumn = location.column + colDelta * distance
        
        guard isThisCellInChessBoardRange(row: targetRow, column: targetColumn) else {
            return nil
        }
        
        let endLocation = ChessBoardLocation(row: targetRow, column: targetColumn)
        let move = ChessMove(startLocation: location, endLocation: endLocation, piece: piece)

        if !doesThisCellHaveAnyPieceOnIt(row: targetRow, column: targetColumn) {
            move.isAttacking = false
            return move
        } else {
            if isThePieceInTheCellOfSameColor(piece: piece, row: targetRow, column: targetColumn) {
                // Friendly piece
                return nil
            } else {
                // Enemy Piece
                move.isAttacking = true
                return move
            }
        }
    }
    
    private func generateMovesInDirection(for piece: ChessPiece,
                                  rowDelta: Int,
                                  colDelta: Int) -> [ChessMove] {
        
        var moves: [ChessMove] = []
        let maxDistance = 7

        for distance in 1...maxDistance {
            
            if let validMove = getValidMove(for: piece,
                                            rowDelta: rowDelta,
                                            colDelta: colDelta,
                                            distance: distance) {
                
                moves.append(validMove)
                
                if validMove.isAttacking {
                    break
                }
                
            } else {
                break
            }
            
        }
        
        return moves
    }
    
    private func doesThisCellHaveAnyPieceOnIt(row: Int, column: Int) -> Bool {
        if let _ = cells[row][column].piece {
            return true
        }
        return false
    }
    
    private func isThisCellInChessBoardRange(row: Int, column: Int) -> Bool {
        return rowRange.contains(row) && columnRange.contains(column)
    }
    
    private func isThisCellValidToMove(row: Int, column: Int) -> Bool {
        if isThisCellInChessBoardRange(row: row, column: column) &&
           !doesThisCellHaveAnyPieceOnIt(row: row, column: column) {
            return true
        }
        return false
    }
    
    private func isThePieceInTheCellOfSameColor(piece: ChessPiece, row: Int, column: Int) -> Bool {
        guard let pieceOnCell = cells[row][column].piece else { return true }
        return piece.color == pieceOnCell.color ? true : false
    }
}

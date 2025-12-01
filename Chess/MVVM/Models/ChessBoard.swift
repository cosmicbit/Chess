//
//  ChessBoard.swift
//  Chess
//
//  Created by Philips Jose on 07/11/25.
//
import Foundation

class ChessBoard {
    let numberOfCells = 64
    var cells: [[ChessBoardCell]] = []
    var chessPieces: [ChessPiece]
    var pieceMap: [ChessBoardLocation: ChessPiece] = [:]
    var gameState = GameState()
    
    init() {
        let blackPieces = ChessPiece.getBlackPieces()
        let whitePieces = ChessPiece.getWhitePieces()
        self.chessPieces = blackPieces + whitePieces
        
        self.pieceMap = self.chessPieces.reduce(into: [:]) { (result, piece) in
            result[piece.location] = piece
        }
        
        self.cells = (0..<8).map { row in
            (0..<8).map { column in
                let location = ChessBoardLocation(row: row, column: column)
                // Look up the piece from the map created in step 2
                let pieceAtLocation = self.pieceMap[location]
                
                // Create the cell and assign the piece (pieceAtLocation will be nil if no piece there)
                return ChessBoardCell(location: location, piece: pieceAtLocation)
            }
        }
    }
    
    func snapshot() {
        print("--- Board Info: -----")
        print("Cell count: \(cells.count)")
        print("Pieces Count: \(chessPieces.count)")
        for i in 0..<8 {
            for j in 0..<8 {
                // Assuming getLocationAsString() is a method on ChessBoardLocation
                let locationString = cells[i][j].location.getLocationAsString()
                let pieceInfo = cells[i][j].piece.map {
                    "Piece = \($0.color.rawValue) \($0.type.rawValue)"
                } ?? "Piece = Blank"
                print("\(locationString) has \(pieceInfo)")
            }
        }
    }
}

extension ChessBoard {
    func changeCellColor(at location: ChessBoardLocation, with color: ChessBoardCellColor) {
        let cell = getCell(from: location)
        cell.currentColor = color
    }
    
    func resetCellColors() {
        self.cells.forEach { rows in
            rows.forEach { cell in
                cell.currentColor = cell.defaultColor
            }
        }
    }
}

extension ChessBoard {
    
    func getLegalMoves(for piece: ChessPiece) -> [ChessMove] {
        var candidateMoves = [ChessMove]()
        
        switch piece.type {
            
        case .king, .knight, .pawn:
            candidateMoves = piece.getDirections().compactMap { direction -> ChessMove? in
                return getValidMove(for: piece, rowDelta: direction.rowChange, colDelta: direction.colChange, distance: 1)
            }
            
        case .queen, .bishop, .rook:
            candidateMoves = piece.getDirections().flatMap {
                return generateMovesInDirection(for: piece, rowDelta: $0.rowChange, colDelta: $0.colChange)
            }
        }
        
        return candidateMoves
    }
    
    private func getValidMove(for piece: ChessPiece,
                              rowDelta: Int,
                              colDelta: Int,
                              distance: Int) -> ChessMove? {
        let targetRow = piece.location.row + rowDelta * distance
        let targetColumn = piece.location.column + colDelta * distance
        
        guard isInBounds(row: targetRow, column: targetColumn) else {
            return nil
        }
        
        let endLocation = ChessBoardLocation(row: targetRow, column: targetColumn)

        if isCellOccupied(row: targetRow, column: targetColumn) {
            
            if isThePieceInTheCellOfSameColor(piece: piece, row: targetRow, column: targetColumn) {
                // Friendly piece
                return nil
            } else {
                // Enemy Piece
                return ChessMove(start: piece.location, end: endLocation, piece: piece, isAttacking: true)
            }
        } else {
            return ChessMove(start: piece.location, end: endLocation, piece: piece, isAttacking: false)
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
    
    private func isCellOccupied(row: Int, column: Int) -> Bool {
        return cells[row][column].piece != nil
    }
    
    private func isCellEmpty(row: Int, column: Int) -> Bool {
        return cells[row][column].piece == nil
    }
    
    private func isInBounds(row: Int, column: Int) -> Bool {
        return (0..<8).contains(row) && (0..<8).contains(column)
    }
    
    private func isThePieceInTheCellOfSameColor(piece: ChessPiece, row: Int, column: Int) -> Bool {
        guard let pieceOnCell = cells[row][column].piece else { return true }
        return piece.color == pieceOnCell.color ? true : false
    }
}

extension ChessBoard {
    func attemptMove(from startLocation: ChessBoardLocation,
                         to endLocation: ChessBoardLocation) -> MoveResult {
            
        guard let pieceToMove = cells[startLocation.row][startLocation.column].piece else {
            return .failure(reason: .noPieceAtStart)
        }
        
        guard pieceToMove.color == gameState.currentPlayer else {
            return .failure(reason: .wrongTurn)
        }

        let legalMoves = self.getLegalMoves(for: pieceToMove)

        let validMove = legalMoves.first { $0.endLocation == endLocation }
        
        guard let move = validMove else {
            return .failure(reason: .illegalMove)
        }

        self.executeMove(move)
        
        return .success
    }
    
    private func executeMove(_ move: ChessMove) {
        let startCell = getCell(from: move.startLocation)
        let endCell = getCell(from: move.endLocation)
        endCell.piece = startCell.piece
        endCell.piece?.location = endCell.location
        startCell.piece = nil
        gameState.togglePlayer()
    }
    
    func getCell(from location: ChessBoardLocation) -> ChessBoardCell {
        return cells[location.row][location.column]
    }
}

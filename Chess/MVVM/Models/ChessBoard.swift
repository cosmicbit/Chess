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
        self.chessPieces = ChessPiece.loadPiecesFromFile(file: Constants.chessPieceDataFile) ?? []
        self.chessPieces.forEach { $0.board = self }
        self.pieceMap = self.chessPieces.reduce(into: [:]) { (result, piece) in
            result[piece.location] = piece
        }
        
        self.cells = (0..<8).map { row in
            (0..<8).map { column in
                let location = ChessBoardLocation(row: row, column: column)
                let pieceAtLocation = self.pieceMap[location]
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
                let locationString = cells[i][j].location.getLocationAsString()
                let pieceInfo = cells[i][j].piece.map {
                    "Piece = \($0.color.rawValue) \($0.type.rawValue)"
                } ?? "Piece = Blank"
                print("\(locationString) has \(pieceInfo)")
            }
        }
    }
}

//MARK: - State Changes
extension ChessBoard {
    
    func changeCellState(at location: ChessBoardLocation, with state: ChessBoardCellState) {
        let cell = getCell(from: location)
        cell.currectState = state
    }
    
    func resetCellColors() {
        self.cells.forEach { rows in
            rows.forEach { cell in
                cell.currectState = .none
            }
        }
    }
}

// MARK: State Info

extension ChessBoard {
    func getCell(from location: ChessBoardLocation) -> ChessBoardCell {
        return cells[location.row][location.column]
    }
}


//MARK: - Move Generation
extension ChessBoard {
    
    func getLegalMoves(for piece: ChessPiece) -> [ChessMove] {
        var candidateMoves = [ChessMove]()
        
        switch piece.type {
            
        case .king, .knight:
            candidateMoves = piece.getDirections().compactMap { direction -> ChessMove? in
                return getValidMove(for: piece, direction: direction, distance: 1)
            }
        case .pawn:
            candidateMoves = getPawnMoves(for: piece)
        case .queen, .bishop, .rook:
            candidateMoves = piece.getDirections().flatMap {
                return generateMovesInDirection(for: piece, direction: $0, distance: 7)
            }
        }
        
        return candidateMoves
    }
    
    private func getPawnMoves(for piece: ChessPiece) -> [ChessMove] {
        
        let directions = piece.getDirections()
        let candidateMoves: [ChessMove] = directions.compactMap { direction -> ChessMove? in
            guard let move = getValidMove(for: piece, direction: direction, distance: 1) else {
                return nil
            }
            let targetLocation = move.endLocation
            
            if direction.key == "UU" {
                if piece.hasMoved {  // UU not allowed if not first Move
                    return nil
                } else {
                    let uDirection = directions.first { $0.key == "U" } ?? Direction(rowChange: 0, colChange: 0, key: "")
                    let uLocation = ChessBoardLocation.getLoc(wrt: piece.location, rowChange: uDirection.rowChange, colChange: uDirection.colChange, distance: 1)
                    if isCellOccupied(loc: uLocation) { // UU not allowed if u is occupied
                        return nil
                    }
                }
            }
                     
            // diagonal attacking allowed only if there is a enemy piece there
            if direction.key == "UL" || direction.key == "UR" {
                if isCellEmpty(loc: targetLocation) {
                    return nil
                }
            }
            
            // Forward attacking not allowed
            if direction.key == "U" {
                if isCellOccupied(loc: targetLocation) {
                    return nil
                }
            }
            
            return move
        }
        
        
        return candidateMoves
    }
    
    private func getValidMove(for piece: ChessPiece,
                              direction: Direction,
                              distance: Int) -> ChessMove? {

        let targetLocation = ChessBoardLocation.getLoc(wrt: piece.location, rowChange: direction.rowChange, colChange: direction.colChange, distance: distance)
        guard isInBounds(loc: targetLocation) else {
            return nil
        }
        
        if isCellOccupied(loc: targetLocation) {
            
            if isThePieceInTheCellOfSameColor(piece: piece, loc: targetLocation) {
                // Friendly piece
                return nil
            } else {
                // Enemy Piece
                return ChessMove(start: piece.location, end: targetLocation, piece: piece, direction: direction, isAttacking: true)
            }
        } else {
            return ChessMove(start: piece.location, end: targetLocation, piece: piece, direction: direction, isAttacking: false)
        }
    }
    
    private func generateMovesInDirection(for piece: ChessPiece,
                                          direction: Direction,
                                          distance: Int) -> [ChessMove] {
        
        var moves: [ChessMove] = []

        for distance in 1...distance {
            
            if let validMove = getValidMove(for: piece,
                                            direction: direction,
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
    
    private func isCellOccupied(loc: ChessBoardLocation) -> Bool {
        return cells[loc.row][loc.column].piece != nil
    }
    
    private func isCellEmpty(loc: ChessBoardLocation) -> Bool {
        return cells[loc.row][loc.column].piece == nil
    }
    
    private func isInBounds(loc: ChessBoardLocation) -> Bool {
        return (0..<8).contains(loc.row) && (0..<8).contains(loc.column)
    }
    
    private func isThePieceInTheCellOfSameColor(piece: ChessPiece, loc: ChessBoardLocation) -> Bool {
        guard let pieceOnCell = getCell(from: loc).piece else { return true }
        return piece.color == pieceOnCell.color ? true : false
    }
}

// MARK: - Move Execution
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
        
        return .success(move: move)
    }
    
    private func executeMove(_ move: ChessMove) {
        let startCell = getCell(from: move.startLocation)
        let endCell = getCell(from: move.endLocation)
        endCell.piece = startCell.piece
        endCell.piece?.hasMoved = true
        startCell.piece = nil
        
        gameState.togglePlayer()
        gameState.moveHistory.append(move)
    }
}

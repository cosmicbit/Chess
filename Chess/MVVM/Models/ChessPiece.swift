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
    var hasMoved: Bool = false
    var board: ChessBoard?
    
    init(color: ChessPieceColor, type: ChessPieceType, location: ChessBoardLocation) {
        self.color = color
        self.type = type
        self.location = location
    }
    
    static func getBlackPieces() -> [ChessPiece] {
        return [
            ChessPiece(color: .black, type: .rook,   location: ChessBoardLocation(row: 0, column: 0)),
            ChessPiece(color: .black, type: .rook,   location: ChessBoardLocation(row: 0, column: 7)),

            ChessPiece(color: .black, type: .knight, location: ChessBoardLocation(row: 0, column: 1)),
            ChessPiece(color: .black, type: .knight, location: ChessBoardLocation(row: 0, column: 6)),
            ChessPiece(color: .black, type: .bishop, location: ChessBoardLocation(row: 0, column: 2)),
            ChessPiece(color: .black, type: .bishop, location: ChessBoardLocation(row: 0, column: 5)),

            ChessPiece(color: .black, type: .king,   location: ChessBoardLocation(row: 0, column: 3)),
            ChessPiece(color: .black, type: .queen,  location: ChessBoardLocation(row: 0, column: 4)),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 0)),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 1)),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 2)),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 3)),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 4)),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 5)),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 6)),
            ChessPiece(color: .black, type: .pawn,   location: ChessBoardLocation(row: 1, column: 7)),
        ]
    }
    
    static func getWhitePieces() -> [ChessPiece] {
        return [
     
            ChessPiece(color: .white, type: .rook,   location: ChessBoardLocation(row: 7, column: 0)),
            ChessPiece(color: .white, type: .rook,   location: ChessBoardLocation(row: 7, column: 7)),
            ChessPiece(color: .white, type: .knight, location: ChessBoardLocation(row: 7, column: 1)),
            ChessPiece(color: .white, type: .knight, location: ChessBoardLocation(row: 7, column: 6)),
            ChessPiece(color: .white, type: .bishop, location: ChessBoardLocation(row: 7, column: 2)),
            ChessPiece(color: .white, type: .bishop, location: ChessBoardLocation(row: 7, column: 5)),
            ChessPiece(color: .white, type: .king,   location: ChessBoardLocation(row: 7, column: 3)),
            ChessPiece(color: .white, type: .queen,  location: ChessBoardLocation(row: 7, column: 4)),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 0)),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 1)),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 2)),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 3)),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 4)),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 5)),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 6)),
            ChessPiece(color: .white, type: .pawn,   location: ChessBoardLocation(row: 6, column: 7)),
        ]
    }
}

extension ChessPiece {
    var asset: UIImage {
        self.type.image(color: self.color)
    }
    /*
    func getAllMoves() -> [ChessMove] {
        let location = self.location
        var moves: [ChessMove] = []
        switch self.type {
        case .king:
            
            var locations: [ChessBoardLocation] = []
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
                //if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                //}
            }
            return moves
        case .queen:
            var locations: [ChessBoardLocation] = []
            
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
                //if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                //}
            }
            return moves
        case .bishop:
            var locations: [ChessBoardLocation] = []
            for i in 1..<8 {
                locations.append(ChessBoardLocation(row: location.row + i, column: location.column + i))
                locations.append(ChessBoardLocation(row: location.row - i, column: location.column - i))
                locations.append(ChessBoardLocation(row: location.row + i, column: location.column - i))
                locations.append(ChessBoardLocation(row: location.row - i, column: location.column + i))
            }
            locations.forEach { loc in
                //if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                //}
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
                //if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                //}
            }
            return moves
        case .rook:
            var locations: [ChessBoardLocation] = []
            for i in 1..<8 {
                locations.append(ChessBoardLocation(row: location.row + i, column: location.column))
                locations.append(ChessBoardLocation(row: location.row, column: location.column + i))
                locations.append(ChessBoardLocation(row: location.row - i, column: location.column))
                locations.append(ChessBoardLocation(row: location.row, column: location.column - i))
            }
            locations.forEach { loc in
                //if let loc = loc {
                    moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                //}
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
                    //if let loc = loc {
                        moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                    //}
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
                    //if let loc = loc {
                        moves.append(ChessMove(startLocation: location, endLocation: loc, piece: self))
                    //}
                }
                
                return moves
            }
        }
    }
    */
    
}

extension ChessPiece {
    func getDirections() -> [Direction] {
        var directions = [(rowChange: Int, colChange: Int, key: String)]()
        switch self.type {
            
        case .king, .queen:
            directions = [
                (-1, -1, "UL"), // UpLeft
                (-1, 0, "U"), // Up
                (-1, 1, "UR"), // UpRight
                (0, 1, "R"),  // Right
                (1, 1, "DR"),  // DownRight
                (1, 0, "D"),  // Down
                (1, -1, "DL"),  // DownLeft
                (0, -1, "L"),  // Left
            ]
        case .bishop:
            directions = [
                (-1, -1, "UL"), // UpLeft
                (-1, 1, "UR"),  // UpRight
                (1, 1, "DR"),  // DownRight
                (1, -1, "DL")  // DownLeft
            ]
            
        case .rook:
            directions = [
                (-1, 0, "U"), // Up
                (0, 1, "R"),  // Right
                (1, 0, "D"),  // Down
                (0, -1, "L")  // Left
            ]
            
        case .knight:
            directions = [
                (-2, -1, "UL"),
                (-2, 1, "UR"),
                (-1, 2, "RU"),
                (1, 2, "RD"),
                (2, 1, "DR"),
                (2, -1, "DL"),
                (1, -2, "LD"),
                (-1, -2, "LU")
            ]
            
        case .pawn:
            switch self.color {
                
            case .white:
                directions = [
                    (-1, -1, "UL"),
                    (-2, 0, "UU"),
                    (-1, 0, "U"),
                    (-1, 1, "R")
                ]
            case .black:
                directions = [
                    (1, 1, "UL"),
                    (2, 0, "UU"),
                    (1, 0, "U"),
                    (1, -1, "R")
                ]
            }
            
        }
        return directions.compactMap {
            Direction(rowChange: $0.rowChange, colChange: $0.colChange, key: $0.key)
        }
    }
}

// MARK: - Parsing Function

extension ChessPiece {
    /**
     Reads and parses chess piece data from a text file.
     
     - Parameter fileName: The name of the text file (e.g., "board_setup").
     - Parameter fileExtension: The extension of the text file (e.g., "txt").
     - Returns: An array of ChessPiece objects, or nil if loading/parsing fails.
     */
    static func loadPiecesFromFile(fileName: String, fileExtension: String) -> [ChessPiece]? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
            print("Error: File not found in bundle.")
            return nil
        }
        
        let fileURL = URL(fileURLWithPath: path)
        var pieces: [ChessPiece] = []
        
        do {
            // 1. Read the entire file content as a single string
            let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
            
            // 2. Split the string into individual lines
            let lines = fileContents.components(separatedBy: .newlines)
            
            // 3. Process each line
            for line in lines {
                // Ignore empty lines (often the last line)
                let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmedLine.isEmpty { continue }
                
                // Split the line by the comma delimiter
                let components = trimmedLine.components(separatedBy: ",")
                
                // A valid piece entry must have exactly 4 components: color, type, row, column
                guard components.count == 4 else {
                    print("Skipping malformed line: \(trimmedLine)")
                    continue
                }
                
                // 4. Safely initialize the piece components
                guard let color = ChessPieceColor(rawValue: components[0]),
                      let type = ChessPieceType(rawValue: components[1]),
                      let row = Int(components[2]),
                      let column = Int(components[3]) else {
                    print("Skipping line due to invalid component value: \(trimmedLine)")
                    continue
                }
                
                // 5. Create and append the ChessPiece
                let location = ChessBoardLocation(row: row, column: column)
                let piece = ChessPiece(color: color, type: type, location: location)
                pieces.append(piece)
            }
            
            return pieces
            
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}

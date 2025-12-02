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
    /*
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
     */
}

extension ChessPiece {
    var asset: UIImage {
        self.type.image(color: self.color)
    }
    
}

extension ChessPiece {
    func getDirections() -> [Direction] {
        var directions: [Direction]
        switch self.type {
            
        case .king, .queen:
            directions = ChessPiece.loadDirectionsFromFile(file: Constants.kingDirections) ?? [] //[
        case .bishop:
            directions = ChessPiece.loadDirectionsFromFile(file: Constants.bishopDirections) ?? []

            
        case .rook:
            directions = ChessPiece.loadDirectionsFromFile(file: Constants.rookDirections) ?? []

        case .knight:
            directions = ChessPiece.loadDirectionsFromFile(file: Constants.knightDirections) ?? []
            
        case .pawn:
            switch self.color {
                
            case .white:
                directions = ChessPiece.loadDirectionsFromFile(file: Constants.whitePawnDirections) ?? []
            case .black:
                directions = ChessPiece.loadDirectionsFromFile(file: Constants.blackPawnDirections) ?? []
            }
            
        }
        return directions
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
    static func loadPiecesFromFile(file: String) -> [ChessPiece]? {
        let fileMeta = file.components(separatedBy: ".")
        
        guard fileMeta.count == 2,
            let lines = Helper.readFromFileAsLines(fileName: fileMeta[0], fileExtension: fileMeta[1])
        else {
            return nil
        }
        var pieces: [ChessPiece] = []
        lines.forEach {
            let components = $0.components(separatedBy: ",")
            guard components.count == 4 else {
                print("Skipping malformed line: \($0)")
                return
            }
            guard let color = ChessPieceColor(rawValue: components[0]),
                  let type = ChessPieceType(rawValue: components[1]),
                  let row = Int(components[2]),
                  let column = Int(components[3]) else {
                print("Skipping line due to invalid component value: \($0)")
                return
            }
            let location = ChessBoardLocation(row: row, column: column)
            let piece = ChessPiece(color: color, type: type, location: location)
            pieces.append(piece)
        }
        return pieces
    }
    
    static func loadDirectionsFromFile(file: String) -> [Direction]? {
        let fileMeta = file.components(separatedBy: ".")
        
        guard fileMeta.count == 2,
            let lines = Helper.readFromFileAsLines(fileName: fileMeta[0], fileExtension: fileMeta[1])
        else {
            return nil
        }
        var directions: [Direction] = []
        lines.forEach {
            guard let components = parseFromLine($0, componentCount: 3),
                    components.count == 3,
                    let rowChange = Int(components[0]),
                    let colChange = Int(components[1])
            else { return }
            let key = String(components[2])
            directions.append(Direction(rowChange: rowChange, colChange: colChange, key: key))
        }
        return directions
    }
    
    static func parseFromLine(_ line: String, componentCount: Int) -> [String]? {
        let components = line.components(separatedBy: ",")
        guard components.count == componentCount else {
            print("Skipping malformed line: \(line)")
            return nil
        }
        return components
    }
}

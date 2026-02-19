//
//  ChessPiece.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import UIKit
import Foundation

struct ChessPiece: Equatable {
    let id = UUID()
    let color: ChessPieceColor
    let type: ChessPieceType
    var hasMoved: Bool = false
    
    init(color: ChessPieceColor, type: ChessPieceType) {
        self.color = color
        self.type = type
    }
}

extension ChessPiece {
    var asset: UIImage? {
        self.type.image(color: self.color)
    }
}

extension ChessPiece {
    func getDirections() -> [Direction] {
        var directions: [Direction]
        switch self.type {
        case .king, .queen:
            directions = ChessPiece.loadDirectionsFromFile(file: Constants.kingDirections) ?? []
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
    static func loadPiecesFromFile(file: String) -> [ChessBoardLocation: ChessPiece]? {
        
        guard let fileMeta = Helper.getFileNameComponents(file),
            let lines = Helper.readFromFileAsLines(fileName: fileMeta[0], fileExtension: fileMeta[1])
        else {
            return nil
        }
        var pieceMap = [ChessBoardLocation: ChessPiece]()
        lines.forEach {
            guard let components = Helper.parseFromLine($0, componentCount: 4),
                  let color = ChessPieceColor(rawValue: components[0]),
                  let type = ChessPieceType(rawValue: components[1]),
                  let row = Int(components[2]),
                  let column = Int(components[3]) else {
                print("Skipping line due to invalid component value: \($0)")
                return
            }
            let location = ChessBoardLocation(row: row, column: column)
            let piece = ChessPiece(color: color, type: type)
            pieceMap.updateValue(piece, forKey: location)
        }
        return pieceMap
    }
    
    static func loadDirectionsFromFile(file: String) -> [Direction]? {
        guard let fileMeta = Helper.getFileNameComponents(file),
            let lines = Helper.readFromFileAsLines(fileName: fileMeta[0], fileExtension: fileMeta[1])
        else {
            return nil
        }
        var directions: [Direction] = []
        lines.forEach {
            guard let components = Helper.parseFromLine($0, componentCount: 3),
                    let rowChange = Int(components[0]),
                    let colChange = Int(components[1])
            else {
                print("Skipping line due to invalid component value: \($0)")
                return
            }
            let key = String(components[2])
            let direction = Direction(rowChange: rowChange, colChange: colChange, key: key)
            directions.append(direction)
        }
        return directions
    }
}

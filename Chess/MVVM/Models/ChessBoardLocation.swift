//
//  ChessBoardLocation.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

import Foundation

struct ChessBoardLocation: Equatable, Hashable, Comparable {
    static func < (lhs: ChessBoardLocation, rhs: ChessBoardLocation) -> Bool {
        if lhs.row < rhs.row {
            return true
        } else if lhs.column < rhs.column {
            return true
        } else {
            return false
        }
    }
    
    
    var row: Int
    var column: Int
    
    func getLocationAsString() -> String {
        return "(\(row), \(column))"
    }

}

extension ChessBoardLocation {
    static func getLoc(wrt location: ChessBoardLocation, rowChange: Int, colChange: Int, distance: Int) -> ChessBoardLocation {
        let row = location.row + rowChange * distance
        let column = location.column + colChange * distance
        return ChessBoardLocation(row: row, column: column)
    }
}

extension ChessBoardLocation {
    func getUCIProtocolString() -> String {
        let fileIndex = UnicodeScalar(97 + self.column)!
        let file = String(fileIndex)
        
        // 2. Convert row (0-7) to Rank (1-8)
        // If row 0 is the top (rank 8), the formula is 8 - row
        let rank = 8 - self.row
        
        return "\(file)\(rank)"
    }
}

extension ChessBoardLocation {
    func offset(by dir: Direction, distance: Int = 1) -> ChessBoardLocation {
        return ChessBoardLocation(
            row: self.row + (dir.rowChange * distance),
            column: self.column + (dir.colChange * distance)
        )
    }
}

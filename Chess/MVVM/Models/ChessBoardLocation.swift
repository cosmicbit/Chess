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

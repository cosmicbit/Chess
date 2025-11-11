//
//  ChessBoardLocation.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//

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
    
    static func initializeObjectIfValid(row: Int, column: Int) -> ChessBoardLocation? {
        if 0 <= row && row < 8 && 0 <= column && column < 8 {
            return ChessBoardLocation(row: row, column: column)
        }
        return nil
    }
    
    init?(row: Int, column: Int) {
        if 0 <= row && row < 8 && 0 <= column && column < 8 {
            //return ChessBoardLocation(row: row, column: column)
            self.row = row
            self.column = column
            return
        }
        return nil
    }
}

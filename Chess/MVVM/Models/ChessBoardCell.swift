//
//  ChessBoardCell.swift
//  Chess
//
//  Created by Philips Jose on 07/11/25.
//
import Foundation

class ChessBoardCell: Hashable, Equatable {
    let location: ChessBoardLocation
    let defaultColor: ChessBoardCellColor
    var currentColor: ChessBoardCellColor
    var piece: ChessPiece?
    init(location: ChessBoardLocation, piece: ChessPiece? = nil) {
        self.location = location
        self.piece = piece
        if ( (location.row + location.column) % 2 == 0) {
            defaultColor = .black
        } else {
            defaultColor = .white
        }
        currentColor = defaultColor
    }
    
    static func==(lhs: ChessBoardCell, rhs: ChessBoardCell) -> Bool {
        lhs.location == rhs.location
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(location)
    }
}


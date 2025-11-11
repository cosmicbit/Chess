//
//  Enums.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//
import UIKit

enum ChessPieceType: String {
    case king, queen, bishop, knight, rook, pawn
    
    func image(color: ChessPieceColor) -> UIImage {
        switch (self, color) {
        case (.king, .black):
            return UIImage.blackKing
        case (.queen, .black):
            return .blackQueen
        case (.bishop, .black):
            return .blackBishop
        case (.knight, .black):
            return .blackKnight
        case (.rook, .black):
            return .blackRook
        case (.pawn, .black):
            return .blackPawn
        case (.king, .white):
            return .whiteKing
        case (.pawn, .white):
            return .whitePawn
        case (.rook, .white):
            return .whiteRook
        case (.knight, .white):
            return .whiteKnight
        case (.bishop, .white):
            return .whiteBishop
        case (.queen, .white):
            return .whiteQueen
        }
    }
    
    
}

enum ChessPieceColor: String {
    case white, black
    
    var uiColor: UIColor {
        switch self {
        case .white:
            UIColor.boardWhite
        case .black:
            UIColor.boardBlack
        }
    }
}

enum ChessBoardCellColor {
    
    case green, black, white, red, yellow
    
    var uiColor: UIColor {
        switch self {
        case .green:
            UIColor.green
        case .black:
            UIColor.boardBlack
        case .white:
            UIColor.boardWhite
        case .red:
            UIColor.red
        case .yellow:
            UIColor.yellow
        }
    }
}

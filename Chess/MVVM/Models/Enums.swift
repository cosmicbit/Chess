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
    
    var woodImage: UIImage {
        switch self {
        case .black:
            UIImage.boardWoodBlack
        case .white:
            UIImage.boardWoodWhite
        default:
            UIImage()
        }
    }
}

enum MoveResult {
    case success(move: ChessMove)
    case failure(reason: FailureReason)
    
    enum FailureReason {
        case noPieceAtStart, wrongTurn, illegalMove
    }
}

enum ChessBoardCellState {
    case none, selected, highlighted
    case vulnerable, check
    case enPassantTarget
    case lastMoveOrigin
    case lastMoveDestination
    
    var asset: UIImage? {
        switch self {
        case .selected:
            UIImage.cellSelected
        case .highlighted:
            UIImage.cellHighlighted
        case .vulnerable:
            UIImage.cellVulnerable
        case .check:
            UIImage.cellCheck
        default:
            nil
        }
    }
}

enum AppTheme: Int, CaseIterable {
    case system, light, dark
    
    var title: String {
        switch self {
        case .system:
            "System"
        case .light:
            "Light"
        case .dark:
            "Dark"
        }
    }
}

enum BoardTheme: Int, CaseIterable {
    case classic, wood, metal
    
    var title: String {
        switch self {
        case .classic:
            "Classic"
        case .wood:
            "Wood"
        case .metal:
            "Metal"
        }
    }
}

enum PieceStyle: Int, CaseIterable {
    case classic, wood, metal
    
    var title: String {
        switch self {
        case .classic:
            "Classic"
        case .wood:
            "Wood"
        case .metal:
            "Metal"
        }
    }
}


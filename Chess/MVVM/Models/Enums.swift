//
//  Enums.swift
//  Chess
//
//  Created by Philips Jose on 06/11/25.
//
import UIKit

enum ChessPieceType: String, Hashable {
    case king, queen, bishop, knight, rook, pawn
    
    func image(color: ChessPieceColor) -> UIImage? {
        switch (self, color) {
        case (.king, .black):
            return AssetManager.Pieces.Classic.blackKing
        case (.queen, .black):
            return AssetManager.Pieces.Classic.blackQueen
        case (.bishop, .black):
            return AssetManager.Pieces.Classic.blackBishop
        case (.knight, .black):
            return AssetManager.Pieces.Classic.blackKnight
        case (.rook, .black):
            return AssetManager.Pieces.Classic.blackRook
        case (.pawn, .black):
            return AssetManager.Pieces.Classic.blackPawn
        case (.king, .white):
            return AssetManager.Pieces.Classic.whiteKing
        case (.pawn, .white):
            return AssetManager.Pieces.Classic.whitePawn
        case (.rook, .white):
            return AssetManager.Pieces.Classic.whiteRook
        case (.knight, .white):
            return AssetManager.Pieces.Classic.whiteKnight
        case (.bishop, .white):
            return AssetManager.Pieces.Classic.whiteBishop
        case (.queen, .white):
            return AssetManager.Pieces.Classic.whiteQueen
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
    
    var woodImage: UIImage? {
        switch self {
        case .black:
            AssetManager.Cells.Wood.black
        case .white:
            AssetManager.Cells.Wood.white
        default:
            nil
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
            AssetManager.CellStates.selected
        case .highlighted:
            AssetManager.CellStates.highlighted
        case .vulnerable:
            AssetManager.CellStates.vulnerable
        case .check:
            AssetManager.CellStates.check
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


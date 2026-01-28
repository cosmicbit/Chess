//
//  Constants.swift
//  Chess
//
//  Created by Philips Jose on 01/12/25.
//

struct Constants {
    static let chessPieceDataFile = "ChessPieceData.txt"
    static let collectionViewCellID = "ChessBoardCollectionViewCell"
    static let kingDirections = "KingDirections.txt"
    static let bishopDirections = "BishopDirections.txt"
    static let rookDirections = "RookDirections.txt"
    static let knightDirections = "KnightDirections.txt"
    static let whitePawnDirections = "WhitePawnDirections.txt"
    static let blackPawnDirections = "BlackPawnDirections.txt"
    
    struct Segues {
        static let splashToModeSegue = "splashToModeSegue"
        static let modeToChessSegue = "modeToChessSegue"
    }
    
    struct Storyboards {
        
    }
}

struct Strings {
    struct Common {
        static let ok = "OK"
    }
    
    struct vsComputerAlert {
        static let title = "Coming Soon..."
        static let description = "This mode will be available soon"
    }
}

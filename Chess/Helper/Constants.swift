//
//  Constants.swift
//  Chess
//
//  Created by Philips Jose on 01/12/25.
//

struct Constants {
    static let chessPieceDataFile = "ChessPieceData.txt"
    static let chessBoardCellID = "ChessBoardCollectionViewCell"
    static let kingDirections = "KingDirections.txt"
    static let bishopDirections = "BishopDirections.txt"
    static let rookDirections = "RookDirections.txt"
    static let knightDirections = "KnightDirections.txt"
    static let whitePawnDirections = "WhitePawnDirections.txt"
    static let blackPawnDirections = "BlackPawnDirections.txt"
}

struct Storyboards {
    static let main = "Main"
    static let splash = "Splash"
    static let launch = "LaunchScreen"
    static let profile = "Profile"
    static let settings = "Settings"
    
    struct Identifiers {
        static let modeVC = "ModeSelectionViewController"
        static let splashVC = "SplashViewController"
        static let chessVC = "ChessViewController"
        static let setttingsVC = "SettingsViewController"
        static let settingsDetailVC = "SettingsDetailViewController"
    }
    
    struct Segues {
        static let modeToChessSegue = "modeToChessSegue"
    }
}

struct TableViewCellIDs {
    static let profileCellWithAvatar = "ProfileCellWithAvatar"
    static let profileCellWithText = "ProfileCellWithText"
}

struct Strings {
    struct Common {
        static let ok = "OK"
    }
    
    struct vsComputerAlert {
        static let title = "Coming Soon..."
        static let description = "This mode will be available soon"
    }
    
    static let TabBarTitles = [
        "Play", "Profile", "Settings"
    ]
    
    static let modeTitles = [
        "Online", "Pass And Play", "Play vs Computer"
    ]
}

struct SystemImageNames {
    static let TabBarImages = [
        "checkerboard.shield", "person.fill", "gear"
    ]
}

//
//  SettingsViewModel.swift
//  Chess
//
//  Created by Philips Jose on 30/01/26.
//

enum SettingType {
    case toggle
    case navigation // For picking pieces or boards
}

struct SettingItem {
    let title: String
    let icon: String
    let type: SettingType
}

struct SettingSection {
    let title: String
    let items: [SettingsDestination]
}

enum SettingsSection: Int, CaseIterable {
    case appearance, audio
    var title: String {
        switch self {
        case .appearance:
            "Appearance"
        case .audio:
            "Audio"
        }
    }
    
    var items: [SettingsDestination] {
        switch self {
        case .appearance:
            [ .boardTheme, .pieceStyle, .showCoordinates, .appTheme ]
        case .audio:
            [ .moveSounds ]
        }
    }
}

enum SettingsDestination {
    case boardTheme, pieceStyle, showCoordinates, appTheme, moveSounds
    
    var details: SettingItem {
        switch self {
        case .boardTheme:
            SettingItem(title: "Board Theme", icon: "grid", type: .navigation)
        case .pieceStyle:
            SettingItem(title: "Piece Style", icon: "checkerboard.rectangle", type: .navigation)
        case .showCoordinates:
            SettingItem(title: "Show Coordinates", icon: "textformat.123", type: .toggle)
        case .appTheme:
            SettingItem(title: "App Theme", icon: "eye", type: .navigation)
        case .moveSounds:
            SettingItem(title: "Move Sounds", icon: "speaker.wave.2.fill", type: .toggle)
        }
    }
}

class SettingsViewModel {
    
    public var sections = [SettingsSection]()
    
    public func setupData() {
        sections = SettingsSection.allCases
    }
}

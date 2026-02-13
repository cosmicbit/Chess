//
//  SettingsDetailViewModel.swift
//  Chess
//
//  Created by Philips Jose on 03/02/26.
//
import UIKit

class SettingsDetailViewModel {
    var currentSetting: SettingsDestination = .appTheme
    var currentSettingOptions: [String] = []
    var currentSelectedOption: Int = 0
    var didChangeAppTheme: () -> Void = {}
    
    public func initialSetup() {
        
        switch currentSetting {
        case .boardTheme:
            currentSettingOptions = BoardTheme.allCases.map({ $0.title })
            currentSelectedOption = AppPreferences.shared.currentBoardTheme.rawValue
        case .pieceStyle:
            currentSettingOptions = PieceStyle.allCases.map({ $0.title })
            currentSelectedOption = AppPreferences.shared.currentPieceStyle.rawValue
        case .appTheme:
            currentSettingOptions = AppTheme.allCases.map({ $0.title })
            currentSelectedOption = AppPreferences.shared.currentAppTheme.rawValue
        default:
            break
        }
    }
    
    public func getCurrentSelectedIndexPath() -> IndexPath {
        IndexPath(row: currentSelectedOption, section: 0)
    }
    
    public func setCurrentSelectedOption(_ option: Int) {
        switch currentSetting {
        case .boardTheme:
            AppPreferences.shared.currentBoardTheme = BoardTheme(rawValue: option) ?? .classic
        case .pieceStyle:
            AppPreferences.shared.currentPieceStyle = PieceStyle(rawValue: option) ?? .classic
        case .appTheme:
            AppPreferences.shared.currentAppTheme = AppTheme(rawValue: option) ?? .system
            self.didChangeAppTheme()
        case .moveSounds, .showCoordinates:
            break
        }
        self.currentSelectedOption = option
    }
}

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
    
    func initialSetup() {
        
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
}

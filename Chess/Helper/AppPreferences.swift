//
//  AppPreferences.swift
//  Chess
//
//  Created by Philips Jose on 28/01/26.
//

import Foundation
import UIKit

struct AppPreferenceKeys {
    static let currentPlayerMode = "currentPlayerMode"
    static let currentAppTheme = "currentAppTheme"
    static let currentBoardTheme = "currentBoardTheme"
    static let currentPieceStyle = "currentPieceStyle"
}

class AppPreferences {
    
    static let shared = AppPreferences()
    
    class func bool(forKey: String) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }
    
    class func value(forKey: String) -> Any? {
        return UserDefaults.standard.value(forKey: forKey)
    }
    
    class func object(forKey: String) -> Any? {
        return UserDefaults.standard.object(forKey: forKey)
    }
    
    class func integer(forKey: String) -> Int {
        return UserDefaults.standard.integer(forKey: forKey)
    }
    
    class func string(forKey : String) -> String? {
        return UserDefaults.standard.string(forKey: forKey)
    }
    
    class func set(_ value: Any, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
}

extension AppPreferences {
    var currentPlayerMode: PlayerMode {
        get {
            let id = AppPreferences.integer(forKey: AppPreferenceKeys.currentPlayerMode)
            let mode = PlayerMode(rawValue: id) ?? .passAndPlay
            return mode
        }
        set {
            AppPreferences.set(newValue.rawValue, forKey: AppPreferenceKeys.currentPlayerMode)
        }
    }
    
    var currentAppTheme: AppTheme {
        get {
            let id = AppPreferences.integer(forKey: AppPreferenceKeys.currentAppTheme)
            let theme = AppTheme(rawValue: id) ?? .system
            return theme
        }
        set {
            AppPreferences.set(newValue.rawValue, forKey: AppPreferenceKeys.currentAppTheme)
        }
    }
    
    var currentBoardTheme: BoardTheme {
        get {
            let id = AppPreferences.integer(forKey: AppPreferenceKeys.currentBoardTheme)
            let theme = BoardTheme(rawValue: id) ?? .classic
            return theme
        }
        set {
            AppPreferences.set(newValue.rawValue, forKey: AppPreferenceKeys.currentBoardTheme)
        }
    }
    
    var currentPieceStyle: PieceStyle {
        get {
            let id = AppPreferences.integer(forKey: AppPreferenceKeys.currentPieceStyle)
            let style = PieceStyle(rawValue: id) ?? .classic
            return style
        }
        set {
            AppPreferences.set(newValue.rawValue, forKey: AppPreferenceKeys.currentPieceStyle)
        }
    }
}

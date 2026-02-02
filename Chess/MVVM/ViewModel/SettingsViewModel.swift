//
//  SettingsViewModel.swift
//  Chess
//
//  Created by Philips Jose on 30/01/26.
//

enum SettingType {
    case toggle(isOn: Bool)
    case navigation(value: String?) // For picking pieces or boards
}

struct SettingItem {
    let title: String
    let icon: String
    let type: SettingType
}

struct SettingSection {
    let title: String
    let items: [SettingItem]
}

class SettingsViewModel {
    
    public var sections = [SettingSection]()
    public func setupData() {
        sections = [
            SettingSection(title: "Appearance", items: [
                SettingItem(title: "Board Theme", icon: "grid", type: .navigation(value: "Wood")),
                SettingItem(title: "Piece Style", icon: "checkerboard.rectangle", type: .navigation(value: "Neo")),
                SettingItem(title: "Show Coordinates", icon: "textformat.123", type: .toggle(isOn: true))
            ]),
            SettingSection(title: "Gameplay", items: [
                SettingItem(title: "Enable Premoves", icon: "bolt.fill", type: .toggle(isOn: true)),
                SettingItem(title: "Always Promote to Queen", icon: "crown.fill", type: .toggle(isOn: false)),
                SettingItem(title: "Confirm Resignation", icon: "flag.fill", type: .toggle(isOn: true))
            ]),
            SettingSection(title: "Audio & Haptics", items: [
                SettingItem(title: "Move Sounds", icon: "speaker.wave.2.fill", type: .toggle(isOn: true)),
                SettingItem(title: "Haptic Feedback", icon: "waveform", type: .toggle(isOn: true))
            ])
        ]
    }
}

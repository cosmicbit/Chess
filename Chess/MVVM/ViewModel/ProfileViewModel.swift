//
//  ProfileViewModel.swift
//  Chess
//
//  Created by Philips Jose on 02/02/26.
//

import Foundation

enum ProfileType {
    case text, date
}

struct ProfileItem {
    var label: String?
    var textField: String?
    let type: ProfileType
}

class ProfileViewModel {
    public var currentUser: User = User(name: "Philips Jose", username: "madvork")
    public var items = [ProfileItem]()
    
    public func setupData() {
        items = [
            ProfileItem(label: "Name", textField: currentUser.name, type: .text),
            ProfileItem(label: "Username", textField: currentUser.username, type: .text)
        ]
    }
}

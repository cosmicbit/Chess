//
//  UIUserInterfaceStyle+Extension.swift
//  Chess
//
//  Created by Philips Jose on 03/02/26.
//

import UIKit

extension UIUserInterfaceStyle {
    var title: String {
        switch self {
        case .unspecified:
            "System"
        case .light:
            "Light"
        case .dark:
            "Dark"
        default:
            ""
        }
    }
}

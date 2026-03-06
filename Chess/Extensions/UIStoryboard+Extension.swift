//
//  UIStoryboard+Extension.swift
//  Chess
//
//  Created by Philips Jose on 06/03/26.
//
import UIKit

extension UIStoryboard {
    static func instantiate<T: UIViewController>(_ type: T.Type, from storyboard: String) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}

//
//  UIView+Extension.swift
//  Chess
//
//  Created by Philips Jose on 15/01/26.
//
import UIKit

extension UIView {
    func showPopAnimation(completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            } completion: { _ in
                completion?()
            }
        }
    }
}

//
//  UIView+Extension.swift
//  Chess
//
//  Created by Philips Jose on 15/01/26.
//
import UIKit

extension UIView {
    func showPopAnimation(completion: @escaping ()->Void = {}) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.transform = CGAffineTransform.identity
            }
        }) { _ in
            completion()
        }
    }
}

extension UIView {
    func snapshotToImage() -> CGImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.cgImage
    }
}

extension UIView {
    @IBInspectable var isCapsuleType: Bool {
        set {
            if newValue {
                self.layer.cornerRadius = self.frame.height / 2
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.layer.cornerRadius = self.frame.height / 2
                }
            }
        }
        get {
            return self.layer.cornerRadius == self.frame.height / 2
        }
    }
}

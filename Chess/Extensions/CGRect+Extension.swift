//
//  CGRect+Extension.swift
//  Chess
//
//  Created by Philips Jose on 28/01/26.
//
import CoreGraphics

extension CGRect {
    func multiplyingBy(_ scale: CGFloat) -> CGRect {
        return CGRect(x: origin.x * scale, y: origin.y * scale, width: width * scale, height: height * scale)
    }
}

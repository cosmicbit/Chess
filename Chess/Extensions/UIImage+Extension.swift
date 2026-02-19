//
//  UIImage+Extension.swift
//  Chess
//
//  Created by Philips Jose on 19/02/26.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        // This helper ensures we don't use more memory than exactly needed
        // for the target square size.
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

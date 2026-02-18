//
//  AssetManager.swift
//  Chess
//
//  Created by Philips Jose on 18/02/26.
//

import UIKit
import ImageIO

struct AssetManager {
    struct Pieces {
        
        struct Classic {
            static let blackKing = UIImage.blackKing
            static let blackQueen = UIImage.blackQueen
            static let blackBishop = UIImage.blackBishop
            static let blackKnight = UIImage.blackKnight
            static let blackRook = UIImage.blackRook
            static let blackPawn = UIImage.blackPawn
            
            static let whiteKing = UIImage.whiteKing
            static let whiteQueen = UIImage.whiteQueen
            static let whiteBishop = UIImage.whiteBishop
            static let whiteKnight = UIImage.whiteKnight
            static let whiteRook = UIImage.whiteRook
            static let whitePawn = UIImage.whitePawn
        }
        
    }
    
    struct Cells {
        struct Wood {
            static let black = UIImage.boardWoodBlack
            static let white = UIImage.boardWoodWhite
        }
    }

    static func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else { return nil }
        
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else { return nil }
        return UIImage(cgImage: downsampledImage)
    }
}

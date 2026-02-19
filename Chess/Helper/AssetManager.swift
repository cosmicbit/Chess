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
            static let blackKing   :UIImage? = UIImage(named: "BlackKing")
            static let blackQueen  :UIImage? = UIImage(named: "BlackQueen")
            static let blackBishop :UIImage? = UIImage(named: "BlackBishop")
            static let blackKnight :UIImage? = UIImage(named: "BlackKnight")
            static let blackRook   :UIImage? = UIImage(named: "BlackRook")
            static let blackPawn   :UIImage? = UIImage(named: "BlackPawn")
            static let whiteKing   :UIImage? = UIImage(named: "WhiteKing")
            static let whiteQueen  :UIImage? = UIImage(named: "WhiteQueen")
            static let whiteBishop :UIImage? = UIImage(named: "WhiteBishop")
            static let whiteKnight :UIImage? = UIImage(named: "WhiteKnight")
            static let whiteRook   :UIImage? = UIImage(named: "WhiteRook")
            static let whitePawn   :UIImage? = UIImage(named: "WhitePawn")
        }
    }
    
    struct Cells {
        struct Wood {
            static let black :UIImage? = UIImage(named: "board_wood_black")?.resized(to: CGSize(width: 100, height: 100))
            static let white :UIImage? = UIImage(named: "board_wood_white")?.resized(to: CGSize(width: 100, height: 100))
        }
    }
    
    struct CellStates {
        static let check       = UIImage(named: "cell_check")
        static let highlighted = UIImage(named: "cell_highlighted")
        static let selected    = UIImage(named: "cell_selected")
        static let vulnerable  = UIImage(named: "cell_vulnerable")
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

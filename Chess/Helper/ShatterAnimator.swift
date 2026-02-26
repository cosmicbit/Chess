//
//  ShatterAnimator.swift
//  Chess
//
//  Created by Philips Jose on 22/01/26.
//


import UIKit

class ShatterAnimator {
    
    static func massiveShatter(view: UIView, rows: Int = 20, cols: Int = 20, completion: @escaping ()->Void = {}) {
        guard let container = view.superview, let image = view.snapshotToImage() else { return }
        
        let frame = view.frame
        let pieceWidth = frame.width / CGFloat(cols)
        let pieceHeight = frame.height / CGFloat(rows)
        
        view.isHidden = true
        
        // We wrap everything in a transaction to use the completion block
        CATransaction.begin()
        
        var createdLayers = [CALayer]()
        
        // This block runs ONLY when all thousands of animations are finished
        CATransaction.setCompletionBlock {
            for layer in createdLayers {
                layer.removeFromSuperlayer()
            }
            createdLayers.removeAll()
            print("Cleanup complete: Thousands of layers removed.")
            completion()
        }

        for row in 0..<rows {
            for col in 0..<cols {
                let layer = CALayer()
                layer.contents = image
                layer.contentsRect = CGRect(x: CGFloat(col)/CGFloat(cols),
                                            y: CGFloat(row)/CGFloat(rows),
                                            width: 1.0/CGFloat(cols),
                                            height: 1.0/CGFloat(rows))
                
                layer.frame = CGRect(x: frame.origin.x + CGFloat(col) * pieceWidth,
                                     y: frame.origin.y + CGFloat(row) * pieceHeight,
                                     width: pieceWidth, height: pieceHeight)
                
                container.layer.addSublayer(layer)
                createdLayers.append(layer)
                
                addShatterAnimation(to: layer)
            }
        }
        
        CATransaction.commit()
    }
    
    static func addShatterAnimation(to layer: CALayer) {
        let duration = Double.random(in: 0.7...1.5)
        
        // Movement: Random X blast, and a Y drop (simulating gravity)
        let xBlast = CGFloat.random(in: -150...150)
        let yDrop = CGFloat.random(in: 200...400) // Positive Y goes down in iOS
        
        let animGroup = CAAnimationGroup()
        animGroup.duration = duration
        animGroup.fillMode = .forwards
        animGroup.isRemovedOnCompletion = false
        
        // 1. Translation (The Fly-away)
        let posAnim = CABasicAnimation(keyPath: "position")
        let endPoint = CGPoint(x: layer.position.x + xBlast, y: layer.position.y + yDrop)
        posAnim.toValue = NSValue(cgPoint: endPoint)
        
        // 2. Rotation (The Spin)
        let rotAnim = CABasicAnimation(keyPath: "transform.rotation")
        rotAnim.toValue = Double.random(in: -Double.pi...Double.pi) * 2
        
        // 3. Opacity (The Fade Out)
        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.toValue = 0.0
        
        animGroup.animations = [posAnim, rotAnim, fadeAnim]
        layer.add(animGroup, forKey: nil)
    }
    
    static func reverseShatter(view: UIView, duration: Double = 1.0, rows: Int = 20, cols: Int = 20, completion: @escaping ()->Void = {}) {
        view.isHidden = false
        guard let container = view.superview, let image = view.snapshotToImage() else { return }
        
        let frame = view.frame
        let pieceWidth = frame.width / CGFloat(cols)
        let pieceHeight = frame.height / CGFloat(rows)
        
        // Ensure the original view stays hidden until the end
        view.isHidden = true
        
        CATransaction.begin()
        var createdLayers = [CALayer]()
        
        CATransaction.setCompletionBlock {
            view.isHidden = false
            for layer in createdLayers {
                layer.removeFromSuperlayer()
            }
            completion()
        }

        for row in 0..<rows {
            for col in 0..<cols {
                let layer = CALayer()
                layer.contents = image
                layer.contentsRect = CGRect(x: CGFloat(col)/CGFloat(cols),
                                            y: CGFloat(row)/CGFloat(rows),
                                            width: 1.0/CGFloat(cols),
                                            height: 1.0/CGFloat(rows))
                
                // The "Target" position (where the piece belongs)
                let targetFrame = CGRect(x: frame.origin.x + CGFloat(col) * pieceWidth,
                                         y: frame.origin.y + CGFloat(row) * pieceHeight,
                                         width: pieceWidth, height: pieceHeight)
                
                // Set initial state to "Exploded" (Far away, rotated, and invisible)
                let xOffset = CGFloat.random(in: -200...200)
                let yOffset = CGFloat.random(in: -300...300)
                layer.frame = targetFrame.offsetBy(dx: xOffset, dy: yOffset)
                layer.opacity = 0
                layer.transform = CATransform3DMakeRotation(CGFloat.random(in: -CGFloat.pi...CGFloat.pi), 0, 0, 1)
                
                container.layer.addSublayer(layer)
                createdLayers.append(layer)
                
                // Animate BACK to the target
                animateBackToHome(
                    layer: layer,
                    duration: duration,
                    targetPosition: CGPoint(x: targetFrame.midX, y: targetFrame.midY)
                )
            }
        }
        
        CATransaction.commit()
    }

    static func animateBackToHome(layer: CALayer, duration: Double = 1.0, targetPosition: CGPoint) {
        let duration = Double.random(in: 0.5...duration)
        
        let animGroup = CAAnimationGroup()
        animGroup.duration = duration
        animGroup.fillMode = .forwards
        animGroup.isRemovedOnCompletion = false
        animGroup.timingFunction = CAMediaTimingFunction(name: .easeOut) // Starts fast, slows down at the end
        
        // 1. Position: Fly back to original spot
        let posAnim = CABasicAnimation(keyPath: "position")
        posAnim.toValue = NSValue(cgPoint: targetPosition)
        
        // 2. Rotation: Straighten out to 0 degrees
        let rotAnim = CABasicAnimation(keyPath: "transform.rotation")
        rotAnim.toValue = 0
        
        // 3. Opacity: Fade in
        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.toValue = 1.0
        
        animGroup.animations = [posAnim, rotAnim, fadeAnim]
        layer.add(animGroup, forKey: nil)
    }
}

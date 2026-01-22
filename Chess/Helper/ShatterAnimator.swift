//
//  ShatterAnimator.swift
//  Chess
//
//  Created by Philips Jose on 22/01/26.
//


import UIKit

class ShatterAnimator {
    
    static func explode(iconView: UIView, completion: @escaping ()->Void = {} ) {
        // 1. Get the top-most container (the window) so the explosion is never hidden
        guard let window = iconView.window else { return }
        
        // Convert the icon's position to window coordinates
        let originInWindow = iconView.convert(iconView.bounds, to: window)
        let centerPoint = CGPoint(x: originInWindow.midX, y: originInWindow.midY)
        
        // 2. Setup the Emitter
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = centerPoint
        emitter.emitterShape = .circle
        emitter.emitterSize = iconView.bounds.size
        emitter.beginTime = CACurrentMediaTime()
        emitter.timeOffset = CFTimeInterval(arc4random_uniform(6))
        emitter.zPosition = 1000 // Force it to the front
        
        // 3. Configure the Particle
        let cell = CAEmitterCell()
        cell.contents = createParticleImage()?.cgImage
        cell.birthRate = 1000  // Intense burst
        cell.lifetime = 1.5
        if let view = iconView as? UILabel {
            cell.color = view.textColor.cgColor
        } else {
            cell.color = iconView.backgroundColor?.cgColor ?? UIColor.systemBlue.cgColor
        }
        
        // Physics - The "Shatter" feel
        cell.velocity = 150
        cell.velocityRange = 100
        cell.emissionRange = .pi * 2
        cell.spin = 3
        cell.alphaSpeed = -0.8 // Fades out slowly
        cell.scale = 0.1
        cell.scaleRange = 0.05
        cell.yAcceleration = 100
        
        emitter.emitterCells = [cell]
        window.layer.addSublayer(emitter)
        
        // 4. THE VITAL PART: Animate the icon hiding + the burst stopping
        UIView.animate(withDuration: 0.1) {
            iconView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            iconView.alpha = 0
        }
        
        // Stop producing new particles almost immediately to create a "pop"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            emitter.birthRate = 0
        }
        
        // Clean up the layer after particles fade
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            emitter.removeFromSuperlayer()
            iconView.removeFromSuperview() // If you actually want it gone
            completion()
        }
    }
    
    static func reassemble(iconView: UIView) {
        guard let window = iconView.window else { return }
        let originInWindow = iconView.convert(iconView.bounds, to: window)
        let centerPoint = CGPoint(x: originInWindow.midX, y: originInWindow.midY)

        let emitter = CAEmitterLayer()
        emitter.emitterPosition = centerPoint
        
        // 1. IMPORTANT: The particles spawn ALONG the outline of this size
        emitter.emitterSize = CGSize(width: 200, height: 200)
        emitter.emitterShape = .circle // Changed to outline so they spawn far away
        emitter.zPosition = 1000

        let cell = CAEmitterCell()
        cell.contents = createParticleImage()?.cgImage
        cell.birthRate = 2000
        
        // 2. LIFETIME: Give them enough time to reach the center
        cell.lifetime = 0.8
        
        // 3. VELOCITY: Negative value pulls them to emitterPosition
        cell.velocity = -150
        cell.velocityRange = -20
        
        cell.emissionRange = .pi * 2
        
        // Fade in and Scale up as they "materialize"
        //cell.alphaValue = 0
        cell.alphaSpeed = 4.0
        cell.scale = 0.01
        cell.scaleSpeed = 0.2
        
        cell.color = iconView.backgroundColor?.cgColor ?? UIColor.systemBlue.cgColor

        emitter.emitterCells = [cell]
        window.layer.addSublayer(emitter)

        // Start icon invisible and tiny
        iconView.alpha = 0
        iconView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        // Trigger the burst
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            emitter.birthRate = 0
        }

        // 4. THE SYNC: Animate the icon appearing right as particles reach the center
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            iconView.alpha = 1
            iconView.transform = .identity
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            emitter.removeFromSuperlayer()
        }
    }
    
    private static func createParticleImage() -> UIImage? {
        // Creates a white square for the particle
        let size = CGSize(width: 12, height: 12)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

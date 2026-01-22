//
//  SplashViewController.swift
//  Chess
//
//  Created by Philips Jose on 22/01/26.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet private weak var logoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //logoLabel.alpha = 1
        ShatterAnimator.reassemble(iconView: logoLabel) {
            self.performSegue(withIdentifier: Constants.Segues.splashToModeSegue, sender: self)
        }
//        self.startSplashAnimation {
//            ShatterAnimator.explode(iconView: self.logoLabel) {
//                self.performSegue(withIdentifier: Constants.Segues.splashToModeSegue, sender: self)
//            }
//        }
    }
    
    private func setupUI() {
        //logoLabel.alpha = 0
    }
    
    private func startSplashAnimation(completion: @escaping (()->Void) = {} ) {
        UIView.animate(withDuration: 3) {
            self.logoLabel.alpha = 1
        } completion: { _ in
            completion()
        }

    }

}

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
        ShatterAnimator.reverseShatter(view: logoLabel, duration: 1.5) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
                self.navigateToNextPage()
            })
        }
    }
    
    private func setupUI() {
        logoLabel.isHidden = true
    }
    
    private func navigateToNextPage() {
        let splashStoryboard = UIStoryboard(
            name: Constants.Storyboards.main,
            bundle: .main
        )
        let controller = splashStoryboard.instantiateInitialViewController()
        view.window?.rootViewController = controller
    }
}

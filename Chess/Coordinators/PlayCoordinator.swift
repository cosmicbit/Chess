//
//  PlayCoordinator.swift
//  Chess
//
//  Created by Philips Jose on 06/03/26.
//

import UIKit

class PlayCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        // Configure the tab bar item here
        navigationController.isNavigationBarHidden = true
        navigationController.tabBarItem.image = TabBar.play.systemImage
    }

    func start() {
        let vc = UIStoryboard.instantiate(ModeSelectionViewController.self, from: Storyboards.main)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showChessVC() {
        let vc = UIStoryboard.instantiate(ChessViewController.self, from: Storyboards.main)
        navigationController.pushViewController(vc, animated: true)
    }
}

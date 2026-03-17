//
//  ProfileCoordinator.swift
//  Chess
//
//  Created by Philips Jose on 06/03/26.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        // Configure the tab bar item here
        navigationController.isNavigationBarHidden = true
        navigationController.tabBarItem.image = TabBar.profile.systemImage
    }

    func start() {
        let vc = UIStoryboard.instantiate(ProfileViewController.self, from: Storyboards.profile)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showSettings() {
        let vc = UIStoryboard.instantiate(SettingsViewController.self, from: Storyboards.settings)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

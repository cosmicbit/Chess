//
//  MainTabBarController.swift
//  Chess
//
//  Created by Philips Jose on 29/01/26.
//

import UIKit

enum TabBar: Int, CaseIterable {
    case play, profile, settings
    var title: String {
        switch self {
        case .play:
            "Play"
        case .profile:
            "Profile"
        case .settings:
            "Settings"
        }
    }
    
    var imageName: String {
        switch self {
        case .play:
            "checkerboard.shield"
        case .profile:
            "person.fill"
        case .settings:
            "gear"
        }
    }
    
    var systemImage: UIImage? {
        return UIImage(systemName: self.imageName)
    }
}

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        configureAppearance()
    }
    
    private func setupTabs() {
        let main = UIStoryboard(name: Constants.Storyboards.main, bundle: .main)
        let playVC = main.instantiateViewController(withIdentifier: Constants.Storyboards.Identifiers.modeVC)

        let profile = UIStoryboard(name: Constants.Storyboards.profile, bundle: .main)
        let profileVC = profile.instantiateInitialViewController() ?? UIViewController()
        
        let settings = UIStoryboard(name: Constants.Storyboards.settings, bundle: .main)
        let settingsVC = settings.instantiateInitialViewController() ?? UIViewController()
	

        let nav1 = createNav(with: TabBar.play, vc: playVC)
        let nav2 = createNav(with: TabBar.profile, vc: profileVC)
        let nav3 = createNav(with: TabBar.settings, vc: settingsVC)

        setViewControllers([nav1, nav2, nav3], animated: true)
    }

    private func createNav(with item: TabBar, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = item.title
        nav.tabBarItem.image = item.systemImage
        nav.isNavigationBarHidden = true
        return nav
    }
    
    private func configureAppearance() {
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .lightGray
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .secondarySystemBackground
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}

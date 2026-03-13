//
//  MainCoordinator.swift
//  Chess
//
//  Created by Philips Jose on 06/03/26.
//
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

enum TabBar: Int, CaseIterable {
    case play, profile, settings
    var title: String {
        return Strings.TabBarTitles[self.rawValue]
    }
    
    var imageName: String {
        return SystemImageNames.TabBarImages[self.rawValue]
    }
    
    var systemImage: UIImage? {
        return UIImage(systemName: self.imageName)
    }
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController = UINavigationController() // Not used for tabs, but required by protocol
    var tabBarController: UITabBarController
    
    // Keep track of child coordinators so they aren't deallocated
    var childCoordinators = [Coordinator]()

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        // 1. Setup Home Tab
        let playNav = UINavigationController()
        let playCoordinator = PlayCoordinator(navigationController: playNav)
        
        // 2. Setup Settings Tab
        let profileNav = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNav)

        // 3. Start Child Coordinators
        self.childCoordinators.append(playCoordinator)
        self.childCoordinators.append(profileCoordinator)
        
        playCoordinator.start()
        profileCoordinator.start()

        // 4. Set the Tab Bar's ViewControllers
        self.tabBarController.viewControllers = [playNav, profileNav]
    }
    
    private func createNav(with item: TabBar) -> UINavigationController {
        let nav = UINavigationController()
        nav.tabBarItem.image = item.systemImage
        nav.isNavigationBarHidden = true
        return nav
    }
    
    private func configureAppearance() {
        self.tabBarController.tabBar.tintColor = .link
        self.tabBarController.tabBar.unselectedItemTintColor = .lightGray
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .secondarySystemBackground
        
        self.tabBarController.tabBar.standardAppearance = appearance
        self.tabBarController.tabBar.scrollEdgeAppearance = appearance
    }
}

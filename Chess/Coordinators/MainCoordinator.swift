//
//  MainCoordinator.swift
//  Chess
//
//  Created by Philips Jose on 06/03/26.
//


class MainCoordinator: Coordinator {
    var navigationController: UINavigationController // Not used for tabs, but required by protocol
    var tabBarController: UITabBarController
    
    // Keep track of child coordinators so they aren't deallocated
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    func start() {
        // 1. Setup Home Tab
        let homeNav = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNav)
        
        // 2. Setup Settings Tab
        let settingsNav = UINavigationController()
        let settingsCoordinator = SettingsCoordinator(navigationController: settingsNav)

        // 3. Start Child Coordinators
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(settingsCoordinator)
        
        homeCoordinator.start()
        settingsCoordinator.start()

        // 4. Set the Tab Bar's ViewControllers
        tabBarController.viewControllers = [homeNav, settingsNav]
    }
}
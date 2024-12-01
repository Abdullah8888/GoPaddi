//
//  Coordinator.swift
//  GoPaddi
//
//  Created by Abdullah on 01/12/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

final class MainCoordinator: NSObject, Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var window: UIWindow
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        let vc = TripLandingController(view: TripLandingView())
        vc.viewModel = DIContainer.container.resolve(TripLandingViewModel.self)
        vc.mainCoordinator = self
        navigationController.setViewControllers([vc], animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func moveToLocation() {
        let child = CreateTripCoordinator(navigationController: navigationController)
        child.mainCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    deinit {
        print("MainCoordinator deallocated")
    }
}

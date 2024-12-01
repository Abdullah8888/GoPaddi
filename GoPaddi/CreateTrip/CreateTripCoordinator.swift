//
//  CreateTripCoordinator.swift
//  GoPaddi
//
//  Created by Abdullah on 01/12/2024.
//

import UIKit

final class CreateTripCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var mainCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LocationController(view: LocationView())
        vc.viewModel = DIContainer.container.resolve(CreateTripViewModel.self)
        vc.createTripCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func moveToPickDate() {
        let vc = PickDateController()
        vc.viewModel = DIContainer.container.resolve(CreateTripViewModel.self)
        vc.createTripCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentEnterTripDetailsController() {
        let vc = EnterTripDetailsController(nibName: .EnterTripDetailsController, bundle: nil)
        vc.createTripCoordinator = self
        vc.viewModel = DIContainer.container.resolve(CreateTripViewModel.self)
        vc.modalPresentationStyle = .custom
        let customTransitionDelegate = CustomModalTransitioningDelegate()
        vc.transitioningDelegate = customTransitionDelegate
        vc.delegate = self
        navigationController.present(vc, animated: true)
    }
    
    func pop(isCompleted: Bool = false) {
        navigationController.popViewController(animated: true)
        if isCompleted {
            mainCoordinator?.childDidFinish(self)
        }
    }
    
    func dismiss(isCompleted: Bool = false, animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }
    
    func goToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
        mainCoordinator?.childDidFinish(self)
    }
    
    deinit {
        debugPrint("CreateTripCoordinator is deallocated")
    }
}

extension CreateTripCoordinator: EnterTripDetailsControllerDelegate {
    func didFinishPlanningTrip() {
        navigationController.dismiss(animated: true)
    }
}

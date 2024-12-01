//
//  ViewController.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import UIKit

final class TripLandingController: BaseController<TripLandingView>, TripHeaderViewDelegate, CreateTripFloatingViewDelegate {
    
    var viewModel: TripLandingViewModel?
     weak var mainCoordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GoPaddi"
        _view.setTripHeaderView()
        _view.tripHeaderView?.delegate = self
        _view.tripHeaderView?.createTripFloatingView.delegate = self
        //showLoader()
        responseListeners()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak viewModel] in
            Task {
                await viewModel?.fetchTrips()
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didEndPlanningTrip), name: NSNotification.Name(NotificationNames.didEndPlanningTrip), object: nil)
    }
    
    func onItemSelected(item: String) {
        debugPrint("onItemSelected >> \(item)")
    }
    
    func onCreateTripClicked() {
        mainCoordinator?.moveToLocation()
    }
    
    func responseListeners() {
        viewModel?.tripEntitiesResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                switch completion {
                case .finished:
                    print("tripEntitiesResponse error")
                case .failure(let error):
                    print("tripEntitiesResponse is \(error)")
                    
                }
                //strongSelf.removeLoader()
            }) , receiveValue: weakify({ strongSelf, data in
                //strongSelf.removeLoader()
                print("details => \(data)")
                strongSelf._view.items = data
                print("show success page")
                
            }))
            .store(in: &subscriptions)
        
        viewModel?.errResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: weakify({ strongSelf, error in
                strongSelf.showToast(message: "\(error.composeErrMessage)")
             
            }))
            .store(in: &subscriptions)
    }
    
    @objc private func didEndPlanningTrip(notification: Notification) {
        Task {
            await viewModel?.fetchTrips()
        }
    }
}




//
//  ViewController.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import UIKit

final class TripLandingController: BaseController<TripLandingView>, TripHeaderViewDelegate, CreateTripFloatingViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GoPaddi"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _view.setTripHeaderView()
        _view.tripHeaderView?.delegate = self
        _view.tripHeaderView?.createTripFloatingView.delegate = self
    }
    
    func onItemSelected(item: String) {
        debugPrint("na me \(item)")
    }
    
    func onCreateTripClicked() {
        let vc = LocationController(view: LocationView())
        navigationController?.pushViewController(vc, animated: true)
    }
}


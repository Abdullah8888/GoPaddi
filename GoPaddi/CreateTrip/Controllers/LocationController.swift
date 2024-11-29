//
//  CreateTripController.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//


import UIKit

final class LocationController: BaseController<LocationView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Where")
        
        let locationData = Constant.locationData.jsonBundleURL?.mapTo(LocationData.self)
        _view.allLocations = locationData?.data ?? []
        _view.filteredLocations = locationData?.data ?? []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

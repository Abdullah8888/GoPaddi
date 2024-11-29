//
//  CreateTripController.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//


import UIKit

final class LocationController: BaseController<LocationView>, LocationViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Where")
        
        let locationData = Constant.locationData.jsonBundleURL?.mapTo(LocationData.self)
        _view.allLocations = locationData?.data ?? []
        _view.filteredLocations = locationData?.data ?? []
        _view.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func onSelectedItem(locationEntity: LocationEntity) {
        let vc = PickDateController()
        navigationController?.pushViewController(vc, animated: false)
    }
}

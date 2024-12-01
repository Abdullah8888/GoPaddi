//
//  DIContainer.swift
//  GoPaddi
//
//  Created by Abdullah on 01/12/2024.
//

import Swinject
import Foundation

final class DIContainer {
    private init() {}
    static let container = Container()
    
    static func register() {
        
        container.register(NetworkService.self) { _ in NetworkService(urlSession: URLSession.shared) }
            .inObjectScope(.container)
        
        container.register(TripRepositoryDelegate.self) { r in
            TripRepository(networkService: r.resolve(NetworkService.self)!)
        }
        
        container.register(TripLandingViewModel.self) { r in
            TripLandingViewModel(tripRepository: r.resolve(TripRepositoryDelegate.self)!)
        }
        
        container.register(CreateTripViewModel.self) { r in
            CreateTripViewModel(tripRepository: r.resolve(TripRepositoryDelegate.self)!)
        }
        .inObjectScope(.container)
        
    }
    
}

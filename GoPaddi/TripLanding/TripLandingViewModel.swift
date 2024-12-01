//
//  TripLandingViewModel.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import Combine

final class TripLandingViewModel {
    
    private let tripRepository: TripRepositoryDelegate
    let tripEntitiesResponse = PassthroughSubject<[TripEntity]?, Never>()
    var errResponse = PassthroughSubject<ErrorReponse, Never>()
    
    init(tripRepository: TripRepositoryDelegate) {
        self.tripRepository = tripRepository
    }
    
    func fetchTrips() async {
        let result = try? await tripRepository.fetchTrips()
        switch result {
        case .success(let response):
            print("fetchTrips >> \(response)")
            tripEntitiesResponse.send(response)
        case .failure(let error):
            print("fetchTrips error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
}

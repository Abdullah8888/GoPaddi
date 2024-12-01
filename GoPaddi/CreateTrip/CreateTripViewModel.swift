//
//  CreateTripViewModel.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import Combine

final class CreateTripViewModel: ObservableObject {
    
    private let tripRepository: TripRepositoryDelegate
    let tripEntityResponse = PassthroughSubject<TripEntity?, Never>()
    var errResponse = PassthroughSubject<ErrorReponse, Never>()
    var selectedLocationEntity: LocationEntity?
    var selectedStartDate: String?
    var selectedEndDate: String?
    var tripName: String?
    var tripDescription: String?
    @Published var selectedTravelStyle: String?
    
    init(tripRepository: TripRepositoryDelegate) {
        self.tripRepository = tripRepository
    }
    
    func createTrip(tripName: String, tripTravelStyle: String, tripLocation: String, tripDescription: String) async {
        let result = try? await tripRepository.createTrip(tripName: tripName, tripTravelStyle: tripTravelStyle, tripLocation: tripLocation, tripDescription: tripDescription)
        switch result {
        case .success(let response):
            tripEntityResponse.send(response)
        case .failure(let error):
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
}

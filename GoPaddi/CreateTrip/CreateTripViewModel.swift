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
    //var selectedTravelStyle: String?
    //var selectedTravelStyle = PassthroughSubject<String?, Never>()
    var tripDescription: String?
    @Published var selectedTravelStyle: String?
    
    init(tripRepository: TripRepositoryDelegate) {
        self.tripRepository = tripRepository
    }
    
    func createTrip(tripName: String, tripStyle: String, tripDescription: String) async {
        let result = try? await tripRepository.createTrip(tripName: tripName, tripStyle: tripStyle, tripDescription: tripDescription)
        switch result {
        case .success(let response):
            print("createTrip >> \(response)")
            tripEntityResponse.send(response)
        case .failure(let error):
            print("createTrip error >> \(error)")
            errResponse.send(error)
        case .none:
            errResponse.send(ErrorReponse(message: "An error occured"))
        }
    }
}

//
//  TripEntity.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import Foundation
protocol TripRepositoryDelegate {
    func createTrip(tripName: String, tripTravelStyle: String, tripLocation: String, tripDescription: String) async throws -> Result<TripEntity?, ErrorReponse>
    func fetchTrips() async throws -> Result<[TripEntity]?, ErrorReponse>
}

final class TripRepository: TripRepositoryDelegate {
    
    private let networkService: NetworkService
    
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchTrips() async throws -> Result<[TripEntity]?, ErrorReponse> {
        do {
            let response = try await networkService.execute(urlString: "\(Constant.baseUrl)/trip", method: .GET, type: [TripEntity].self, bodyPayload: [:])
            switch response {
            case .success(let tripEntities):
                return .success(tripEntities)
            case .failure(let errorResponse):
                return .failure(errorResponse)
            }
        }
        catch {
            return .failure(ErrorReponse(message: error.localizedDescription))
        }
    }
    
    func createTrip(tripName: String, tripStyle: String, tripDescription: String) {
        
    }
    
    func createTrip(tripName: String, tripTravelStyle: String, tripLocation: String, tripDescription: String) async throws -> Result<TripEntity?, ErrorReponse> {
        
        do {
            let bodyPayload: [String: Any] = [
                "tripName": tripName,
                "tripTravelStyle": tripTravelStyle,
                "tripLocation": tripLocation,
                "tripDescription": tripDescription
            ]
            
            let response = try await networkService.execute(urlString: "\(Constant.baseUrl)/trip", method: .POST, type: TripEntity.self, bodyPayload: bodyPayload)
            switch response {
            case .success(let tripEntities):
                return .success(tripEntities)
            case .failure(let errorResponse):
                return .failure(errorResponse)
            }
        }
        catch {
            return .failure(ErrorReponse(message: error.localizedDescription))
        }
    }
}

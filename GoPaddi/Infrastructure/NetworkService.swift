//
//  NetworkService.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import Foundation

final class NetworkService {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func execute<T: Codable>(urlString: String, method: String, type: T.Type, bodyPayload: [String: Any?]? = nil) async throws -> Result<T?, ErrorReponse> where T : Decodable, T : Encodable {
        do {
            debugPrint("full url => \(urlString)")
            var urlRequest = URLRequest(url: URL(string: urlString)!)
            urlRequest.httpMethod = method
            if bodyPayload != nil && bodyPayload?.isNotEmpty ?? false {
                let bodyData = try? JSONSerialization.data(withJSONObject: bodyPayload as Any, options: [])
                urlRequest.httpBody = bodyData
            }
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, urlResponse) = try await urlSession.data(for: urlRequest)
            var decodedResponse: T?
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            let statusCode = httpResponse.statusCode
            let allowedStatusCode = 200...299
            if allowedStatusCode.contains(statusCode) {
                // Successful response
                let res = String(data: data, encoding: .utf8) // For debugging
                print("debugging res => \(res)")
                decodedResponse = try? JSONDecoder().decode(T.self, from: data)
                if decodedResponse == nil {
                    let errorResponse = try? JSONDecoder().decode(ErrorReponse.self, from: data)
                    return .failure(errorResponse ?? ErrorReponse(message: "Unknow error occured"))
                }
            } else {
                let res = String(data: data, encoding: .utf8)
                debugPrint("string res is \(res)")
                var errorResponse = try? JSONDecoder().decode(ErrorReponse.self, from: data)
                return .failure(errorResponse ?? ErrorReponse(message: "Unknow error occured"))
            }
            return .success(decodedResponse)
        }
        catch {
            let errorResponse = ErrorReponse(message: error.localizedDescription)
            return .failure(errorResponse)
        }
    }
}

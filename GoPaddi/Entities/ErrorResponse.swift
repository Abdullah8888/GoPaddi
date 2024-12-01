//
//  ErrorResponse.swift
//  GoPaddi
//
//  Created by Abdullah on 30/11/2024.
//

struct ErrorReponse: Codable, Error {
    var message: String? = ""
    var error: String? = ""
    var status: Int?
}

extension ErrorReponse {
    var composeErrMessage: String {
        if message!.isEmpty && error!.isEmpty {
            return "An error occured"
        }
        return "\(error!), \(message!)"
    }
}

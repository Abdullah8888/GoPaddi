//
//  String+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import Foundation

extension String {
    var jsonBundleURL: URL? { Bundle.main.url(forResource: self, withExtension: "json") }
    
    static let GET = "GET"
    
    static let POST = "POST"
    
    static let EnterTripDetailsController = "EnterTripDetailsController"
}

//
//  URL+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import Foundation
public extension URL {
    func mapTo<T: Codable>(_ type: T.Type) -> T? {
        try? JSONDecoder().decode(type, from: Data(contentsOf: self))
    }
}

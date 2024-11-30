//
//  Date+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 30/11/2024.
//

import Foundation
extension Date {
    func dateOnly() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

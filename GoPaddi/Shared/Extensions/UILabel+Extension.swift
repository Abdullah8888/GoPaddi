//
//  UILabel+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 30/11/2024.
//

import UIKit
import Combine

extension UILabel {
    var publisher: AnyPublisher<String?, Never> {
        Just(self.text)
            .eraseToAnyPublisher()
    }
}

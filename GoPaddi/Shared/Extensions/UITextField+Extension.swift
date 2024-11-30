//
//  UITextField+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 30/11/2024.
//

import UIKit
import Combine

extension UITextField {
    var publisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}

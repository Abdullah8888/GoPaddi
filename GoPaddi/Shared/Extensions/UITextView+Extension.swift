//
//  UITextView+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 30/11/2024.
//

import UIKit
import Combine

extension UITextView {
    var publisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextView)?.text }
            .eraseToAnyPublisher()
    }
}

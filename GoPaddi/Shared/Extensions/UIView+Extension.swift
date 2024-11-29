//
//  UIView+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import Foundation
import UIKit

extension UIView {

    func onClick(completion: (() -> Void)? = nil) {
        addTapGesture {
            completion?()
        }
    }
    
    func addTapGesture(action: @escaping () -> Void ){
        let tap = BindableGestureRecognizer(action: action)
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
}

final class BindableGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
    }
    
    @objc private func execute() {
        action()
    }
}

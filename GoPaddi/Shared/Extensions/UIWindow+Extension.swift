//
//  UIWindow+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 01/12/2024.
//

import UIKit
extension UIWindow {
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            return keyWindow
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

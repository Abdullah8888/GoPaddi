//
//  UIFont+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 27/11/2024.
//

import UIKit
extension UIFont {

    static func satoshiMedium(size: CGFloat = 14) -> UIFont { UIFont(name: "Satoshi-Medium", size: size) ?? UIFont.systemFont(ofSize: size) }
    
    static func satoshiBold(size: CGFloat = 14) -> UIFont { UIFont(name: "Satoshi-Bold", size: size) ?? UIFont.systemFont(ofSize: size) }

    static func satoshiRegular(size: CGFloat = 14) -> UIFont { UIFont(name: "Satoshi-Regular", size: size) ?? UIFont.systemFont(ofSize: size) }
    
    static func satoshiSemiBold(size: CGFloat = 14) -> UIFont { UIFont(name: "Satoshi-Bold", size: size) ?? UIFont.systemFont(ofSize: size) }

    static func satoshiExtraBold(size: CGFloat = 14) -> UIFont { UIFont(name: "Satoshi-Black", size: size)! }
}

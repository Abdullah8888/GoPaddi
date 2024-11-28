//
//  UIColor+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 27/11/2024.
//

import UIKit
extension UIColor {
    convenience init(hex: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:   String = hex
        
        if hex.hasPrefix("#") {
            let index   = hex.index(hex.startIndex, offsetBy: 1)
            hex = hex.substring(from: index)
        }
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension UIColor {
    class func compare(_ colorA: UIColor?, with colorB: UIColor?, in view: UIView) -> Bool {
        colorA?.resolvedColor(with: view.traitCollection) == colorB?.resolvedColor(with: view.traitCollection)
    }
}

extension UIColor {
    
    @nonobjc class var hexFFFFFF: UIColor{
        return UIColor(hex: "#FFFFFF")
    }
    @nonobjc class var hexF9FAFB: UIColor{
        return UIColor(hex: "#F9FAFB")
    }
    @nonobjc class var hexE4E7EC: UIColor{
        return UIColor(hex: "#E4E7EC")
    }
    @nonobjc class var hex647995: UIColor{
        return UIColor(hex: "#647995")
    }
    @nonobjc class var hex676E7E: UIColor{
        return UIColor(hex: "#676E7E")
    }
    @nonobjc class var hex0D6EFD: UIColor{
        return UIColor(hex: "#0D6EFD")
    }
    @nonobjc class var hex1D2433: UIColor{
        return UIColor(hex: "#1D2433")
    }
}

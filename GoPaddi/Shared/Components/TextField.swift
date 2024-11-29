//
//  TextField.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import UIKit

final class TextField: UITextField {

    var padding: UIEdgeInsets = .sides(20, 20)

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

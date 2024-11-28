//
//  Label.swift
//  GoPaddi
//
//  Created by Abdullah on 27/11/2024.
//

import UIKit

final class Label: UILabel {
    
    private var insets = UIEdgeInsets.zero
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + insets.left + insets.right, height: originalSize.height + insets.top + insets.bottom)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(padding: UIEdgeInsets = .zero, font: UIFont = .satoshiRegular()) {
        super.init(frame: .zero)
        self.insets = padding
        self.font = font
    }
}

//
//  BaseView.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import UIKit

class BaseView: UIView {

    let customNavHeight = Constant.statusBarFrameHeight + 55 + 20
    
    func setup(){
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
    }

    func layout() {}
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearAll() {
        subviews.forEach{ $0.removeFromSuperview() }
    }
}

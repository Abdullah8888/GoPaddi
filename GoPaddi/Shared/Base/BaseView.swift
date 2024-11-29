//
//  BaseView.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import UIKit

class BaseView: UIView {

    let customNavHeight = Constant.statusBarFrameHeight + 55 + 20
    var contentHeight: CGFloat?
    
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
    
    func updateContentHeight() {
        var totalHeight: CGFloat = 0.0
        var verticalDistance: CGFloat = 0.0
        for subview in subviews {
            print("subview.frame.size lala is \(subview.frame), \(subview.frame.maxY) \(subview.frame.minY), \(subview.frame.height)")
            print("subview.bounds lala is \(subview.bounds), \(subview.bounds.maxY) \(subview.bounds.minY) \(subview.bounds.height)")
            if subview.frame.size.height > 0 {
                totalHeight += subview.bounds.maxY
                print("output is \(totalHeight)")
                
            }
        }
        
        for (index, currentView) in subviews.enumerated() {
            if index + 1 < subviews.count {
                let nextView = subviews[index + 1]
                verticalDistance = nextView.frame.minY - currentView.frame.maxY
            }
        }
        debugPrint("verticalDistance is \(verticalDistance)")
        
        
        var totalVerticalDistance: CGFloat = 0.0
        for (index, currentView) in subviews.enumerated() {
            if index + 1 < subviews.count {
                let nextView = subviews[index + 1]
                let verticalDistanceDiff = nextView.frame.minY - currentView.frame.maxY
            
                totalVerticalDistance += verticalDistanceDiff
            }
        }
        debugPrint("totalVerticalDistance is \(totalVerticalDistance)")
        contentHeight = totalHeight
        debugPrint("contentHeight output is \(contentHeight)")
    }
}

class BaseCollectionViewCell: UICollectionViewCell {
    func setup(){
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseTableViewCell: UITableViewCell,
                              UITextFieldDelegate {
    
    func setup(){
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

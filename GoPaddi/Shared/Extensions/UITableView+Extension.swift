//
//  UITableView+Extension.swift
//  GoPaddi
//
//  Created by Abdullah on 28/11/2024.
//

import UIKit
extension UITableView {
    
    func showLoading() {
        let container = UIView()
        
        let activity: UIActivityIndicatorView = {
            let activity = UIActivityIndicatorView.init(style: .large)
            activity.startAnimating()
            return activity
        }()
        
        container.addSubviews(activity)
        container.backgroundColor = .hex1D2433
        activity.placeAtCenterOf(centerY: container.centerYAnchor, centerX: container.centerXAnchor, size: .init(width: 30, height: 30))
        
        backgroundView = container
    }
    
    func setEmptyView(_ message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = Label(font: .satoshiBold(size: 16))
        messageLabel.textAlignment = .center
        messageLabel.text = message
        emptyView.addSubview(messageLabel)
        messageLabel.fillUpSuperview()
//        messageLabel.anchor(top: emptyView.topAnchor, leading: emptyView.leadingAnchor, trailing: emptyView.trailingAnchor, margin: .init(top: 40, left: 15, bottom: 0, right: 15))
        self.backgroundView = emptyView
        
        
        
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

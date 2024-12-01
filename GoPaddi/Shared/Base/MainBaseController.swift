//
//  MainBaseController.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import UIKit
import Toast
import Combine

class MainBaseController: UIViewController {

    var subscriptions: Set<AnyCancellable> = []
    
    private let loaderContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()
    
    private let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView.init(style: .large)
        activity.startAnimating()
        return activity
    }()
    
    var onTapClose: ( () -> Void )?
    
    func setupNavigationBar(title: String) {
        
        let iconBarButton = UIBarButtonItem(
            image: UIImage(named: "cancel_icon"),
            style: .plain,
            target: self,
            action: #selector(didTapClose)
        )
        
        iconBarButton.tintColor = .black
        
        
        let textBarButton = UIBarButtonItem(
            title: title,
            style: .plain,
            target: nil,
            action: nil
        )
        textBarButton.setTitleTextAttributes([
            .font: UIFont.satoshiBold(size: 18),
            .foregroundColor: UIColor.hex1D2433
        ], for: .normal)
        
        
        navigationItem.setLeftBarButtonItems([iconBarButton, textBarButton], animated: false)
    }
    
    @objc private func didTapClose() {
        //navigationController?.popViewController(animated: true)
        onTapClose?()
    }
    
    func showToast(message: String) {
        let toast = Toast.text(message)
        toast.show()
    }
    
    func showLoader() {
        guard let keyWindow = UIWindow.keyWindow else { return }
        if keyWindow.subviews.contains(loaderContainer) {
            return
        }
        keyWindow.addSubview(loaderContainer)
        loaderContainer.anchor(top: keyWindow.topAnchor, leading: keyWindow.leadingAnchor, bottom: keyWindow.bottomAnchor, trailing: keyWindow.trailingAnchor)
        keyWindow.bringSubviewToFront(loaderContainer)
        
        loaderContainer.addSubview(activity)
        activity.placeAtCenterOf(centerY: loaderContainer.centerYAnchor, centerX: loaderContainer.centerXAnchor)
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            self.loaderContainer.removeFromSuperview()
        }
    }
}

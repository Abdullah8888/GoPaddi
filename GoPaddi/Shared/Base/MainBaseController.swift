//
//  MainBaseController.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import UIKit

class MainBaseController: UIViewController {

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
        navigationController?.popViewController(animated: true)
    }
}

//
//  CreateTripFloatingView.swift
//  GoPaddi
//
//  Created by Abdullah on 28/11/2024.
//

import UIKit

final class CreateTripFloatingView: BaseView {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    let cityContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF9FAFB
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hexE4E7EC.cgColor
        return view
    }()
    
    let startDateContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF9FAFB
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hexE4E7EC.cgColor
        return view
    }()
    
    let endDateContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF9FAFB
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hexE4E7EC.cgColor
        return view
    }()
    
    
    lazy var horizontalStack: HorizontalStack = {
        let stack = HorizontalStack(arrangedSubviews: [startDateContainerView, endDateContainerView])
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    lazy var verticalStackView: VerticalStackView = {
        let stack = VerticalStackView(arrangedSubviews: [cityContainerView,horizontalStack])
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    let locationIcon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "location_icon"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let dateIcon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "date_icon"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let dateIcon2: UIImageView = {
        let img = UIImageView(image: UIImage(named: "date_icon"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let whereToLabel: Label = {
        let label = Label(font: .satoshiMedium(size: 12))
        label.text = "Where to ?"
        label.textColor = .hex647995
        return label
    }()
    
    let selectCityLabel: Label = {
        let label = Label(font: .satoshiBold())
        label.text = "Select City"
        label.textColor = .hex676E7E
        return label
    }()
    
    let startDateLabel: Label = {
        let label = Label(font: .satoshiMedium(size: 12))
        label.text = "Start Date"
        label.textColor = .hex647995
        return label
    }()
    
    let enterStartDateLabel: Label = {
        let label = Label(font: .satoshiBold())
        label.text = "Enter Date"
        label.textColor = .hex676E7E
        return label
    }()
    
    let endDateLabel: Label = {
        let label = Label(font: .satoshiMedium(size: 12))
        label.text = "End Date to ?"
        label.textColor = .hex647995
        return label
    }()
    
    let enterEndDateLabel: Label = {
        let label = Label(font: .satoshiBold())
        label.text = "Enter Date"
        label.textColor = .hex676E7E
        return label
    }()
    
    let createTipBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Create Trip", for: .normal)
        btn.titleLabel?.font = .satoshiExtraBold()
        btn.backgroundColor = .hex0D6EFD
        btn.layer.cornerRadius = 4
        return btn
    }()
    
    override func setup() {
        super.setup()
        cityContainerView.addSubviews(locationIcon, whereToLabel, selectCityLabel)
        locationIcon.placeAtLeftCenterOf(centerY: cityContainerView.centerYAnchor, leading: cityContainerView.leadingAnchor, margin: .leftOnly(10))
        whereToLabel.anchor(top: locationIcon.topAnchor, leading: locationIcon.trailingAnchor, margin: .topLeftOnly(-9, 10))
        selectCityLabel.anchor(leading: locationIcon.trailingAnchor,bottom: locationIcon.bottomAnchor, margin: .bottomLeftOnly(-9, 10))
        
        
        startDateContainerView.addSubviews(dateIcon, startDateLabel, enterStartDateLabel)
        dateIcon.placeAtLeftCenterOf(centerY: startDateContainerView.centerYAnchor, leading: startDateContainerView.leadingAnchor, margin: .leftOnly(10))
        startDateLabel.anchor(top: dateIcon.topAnchor, leading: dateIcon.trailingAnchor, margin: .topLeftOnly(-9, 10))
        enterStartDateLabel.anchor(leading: dateIcon.trailingAnchor,bottom: dateIcon.bottomAnchor, margin: .bottomLeftOnly(-9, 10))
        
        endDateContainerView.addSubviews(dateIcon2, endDateLabel, enterEndDateLabel)
        dateIcon2.placeAtLeftCenterOf(centerY: endDateContainerView.centerYAnchor, leading: endDateContainerView.leadingAnchor, margin: .leftOnly(10))
        endDateLabel.anchor(top: dateIcon2.topAnchor, leading: dateIcon2.trailingAnchor, margin: .topLeftOnly(-9, 10))
        enterEndDateLabel.anchor(leading: dateIcon2.trailingAnchor,bottom: dateIcon2.bottomAnchor, margin: .bottomLeftOnly(-9, 10))
        
        
        
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 220))
        
        containerView.addSubviews(verticalStackView, createTipBtn)
        

        createTipBtn.anchor(leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, margin: .init(top: 0, left: 13, bottom: 13, right: 13), size: .init(width: 0, height: 50))
        
        verticalStackView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: createTipBtn.topAnchor, trailing: containerView.trailingAnchor, margin: .init(allEdges: 13))
        
    }
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, *)
struct CreateTripFloatingViewPreview: PreviewProvider {
    static var previews: some View {
        BasePreviewProvider<CreateTripFloatingView>()
    }
}
#endif

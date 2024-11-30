//
//  ChooseDateView.swift
//  GoPaddi
//
//  Created by Abdullah on 30/11/2024.
//

import UIKit

final class ChooseDateView: BaseView {
    
    let mainContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.hexF0F2F5.cgColor
        return view
    }()
    
    let startDateHeaderLabel: Label = {
        let label = Label( font: .satoshiMedium(size: 12))
        label.textColor = .hex1D2433
        label.text = "Start Date"
        return label
    }()
    
    let endDateHeaderLabel: Label = {
        let label = Label( font: .satoshiMedium(size: 12))
        label.textColor = .hex1D2433
        label.text = "End Date"
        return label
    }()
    
    lazy var headerHorizontalStack: HorizontalStack = {
        let stack = HorizontalStack(arrangedSubviews: [startDateHeaderLabel,endDateHeaderLabel])
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    let startDateView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.hex98A2B3.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    let endDateView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.hex98A2B3.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    lazy var dateHorizontalStack: HorizontalStack = {
        let stack = HorizontalStack(arrangedSubviews: [startDateView,endDateView])
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        stack.constrainHeight(constant: 50)
        return stack
    }()
    
    let startDateLabel: Label = {
        let label = Label( padding: .leftOnly(15), font: .satoshiMedium())
        label.textColor = .hex1D2433
        return label
    }()
    
    let endDateLabel: Label = {
        let label = Label( padding: .leftOnly(15), font: .satoshiMedium())
        label.textColor = .hex1D2433
        return label
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
    
    let chooseDateBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Choose Date", for: .normal)
        btn.titleLabel?.font = .satoshiExtraBold()
        btn.backgroundColor = .hex0D6EFD
        btn.layer.cornerRadius = 4
        btn.constrainHeight(constant: 48)
        return btn
    }()
    
    lazy var verticalStackView: VerticalStackView = {
        let stack = VerticalStackView(arrangedSubviews: [headerHorizontalStack,dateHorizontalStack,chooseDateBtn])
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override func setup() {
        super.setup()
        addSubview(mainContainerView)
        mainContainerView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 165))
        
        mainContainerView.addSubview(verticalStackView)
        
        verticalStackView.anchor(top: mainContainerView.topAnchor, leading: mainContainerView.leadingAnchor, trailing: mainContainerView.trailingAnchor, margin: .init(top: 10, left: 20, bottom: 10, right: 20))
        
        startDateView.addSubviews(startDateLabel, dateIcon)

        dateIcon.anchor(top: startDateView.topAnchor, bottom: startDateView.bottomAnchor, trailing: startDateView.trailingAnchor, margin: .rightOnly(10), size: .init(width: 15, height: 0))

        startDateLabel.anchor(top: startDateView.topAnchor, leading: startDateView.leadingAnchor, bottom: startDateView.bottomAnchor, trailing: dateIcon.leadingAnchor)

        endDateView.addSubviews(endDateLabel, dateIcon2)

        dateIcon2.anchor(top: endDateView.topAnchor, bottom: endDateView.bottomAnchor, trailing: endDateView.trailingAnchor, margin: .rightOnly(10), size: .init(width: 15, height: 0))

        endDateLabel.anchor(top: endDateView.topAnchor, leading: endDateView.leadingAnchor, bottom: endDateView.bottomAnchor, trailing: dateIcon2.leadingAnchor)
    }
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, *)
struct ChooseDateViewPreview: PreviewProvider {
    static var previews: some View {
        BasePreviewProvider<ChooseDateView>()
    }
}
#endif

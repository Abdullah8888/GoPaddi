//
//  TripHeaderView.swift
//  GoPaddi
//
//  Created by Abdullah on 27/11/2024.
//

import UIKit

protocol TripHeaderViewDelegate: AnyObject {
    func onItemSelected(item: String)
}

final class TripHeaderView: BaseView {

    let headerLabel: Label = {
        let label = Label(padding: .init(top: 15, left: 50, bottom: 15, right: 15), font: .satoshiBold(size: 18))
        label.text = "Plan a Trip"
        //label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let titleLabel: Label = {
        let label = Label(padding: .leftOnly(20), font: .satoshiBold(size: 18))
        label.text = "Plan Your Dream Trip in Minutes"
        //label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let subTextLabel: Label = {
        let label = Label(padding: .sides(20, 20), font: .satoshiMedium())
        label.text = "Build, personalize, and optimize your itineraries with our trip planner. Perfect for getaways, remote workcations, and any spontaneous escapade."
        //label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    let bgImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "bg_image_two"))
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .yellow
        //img.isHidden = true
        return img
    }()
    
    let createTripFloatingView: CreateTripFloatingView = {
        let view = CreateTripFloatingView()
        return view
    }()
    
    let yourTripTitleLabel: Label = {
        let label = Label(padding: .topOnly(20), font: .satoshiBold(size: 16))
        label.text = "Your Trips"
        label.textColor = .hex1D2433
        return label
    }()
    
    let yourTripSubTitleLabel: Label = {
        let label = Label(font: .satoshiMedium(size: 12))
        label.text = "Your trip itineraries and  planned trips are placed here"
        label.textColor = .hex676E7E
        return label
    }()
    
    private let dropDownContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF0F2F5
        view.layer.cornerRadius = 4
        return view
    }()
    
    private var dropdownView: DropdownView?
    
    private var emptyMessageLabel: Label?
    
    weak var delegate: TripHeaderViewDelegate?
    
    override func setup() {
        super.setup()
        addSubviews(headerLabel, bgImage, titleLabel, subTextLabel, createTripFloatingView, yourTripTitleLabel, yourTripSubTitleLabel)
        headerLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        bgImage.anchor(top: headerLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 500))
        titleLabel.anchor(top: headerLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .topOnly(60))
        subTextLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .topOnly(15))
        createTripFloatingView.anchor(top: subTextLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .init(top: 70, left: 50, bottom: 0, right: 50), size: .init(width: 0, height: 220))
       
        yourTripTitleLabel.anchor(top: bgImage.bottomAnchor, leading: leadingAnchor, margin: .leftOnly(13))
        
        yourTripSubTitleLabel.anchor(top: yourTripTitleLabel.bottomAnchor, leading: leadingAnchor, margin: .topLeftOnly(10, 13))
    
        addSubview(dropDownContainerView)
        dropDownContainerView.anchor(top: yourTripSubTitleLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .init(top: 20, left: 12, bottom: 0, right: 13), size: .init(width: 0, height: 70))
        
        
        dropdownView = DropdownView(items: ["Planned Trips", "Trip 2", "Trip 3", "Trip 4", "Trip 5"])
        dropdownView?.onItemSelected = { [weak self] selectedItem  in
            print("Selected item: \(selectedItem)")
            self?.delegate?.onItemSelected(item: selectedItem)

        }
        
        dropDownContainerView.addSubview(dropdownView!)
        dropdownView?.fillUpSuperview(margin: .init(allEdges: 10))
        
       //bringSubviewToFront(dropdownView!)
    }
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, *)
struct TripHeaderViewPreview: PreviewProvider {
    static var previews: some View {
        BasePreviewProvider<TripHeaderView>()
    }
}
#endif

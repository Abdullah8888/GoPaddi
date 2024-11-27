//
//  TripHeaderView.swift
//  GoPaddi
//
//  Created by Abdullah on 27/11/2024.
//

import UIKit

final class TripHeaderView: BaseView {
    

    let headerLabel: Label = {
        let label = Label(padding: .init(top: 15, left: 50, bottom: 15, right: 15))
        label.text = "Plan a Trip"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let titleLabel: Label = {
        let label = Label(padding: .leftOnly(20))
        label.text = "Plan Your Dream Trip in Minutes"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let subTextLabel: Label = {
        let label = Label(padding: .leftOnly(20))
        label.text = "Build, personalize, and optimize your itineraries with our trip planner. Perfect for getaways, remote workcations, and any spontaneous escapade."
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    let bgImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "bg_image"))
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .yellow
        return img
    }()
    
    override func setup() {
        super.setup()
        addSubviews(headerLabel, bgImage, titleLabel, subTextLabel)
        headerLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        bgImage.anchor(top: headerLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 500))
        titleLabel.anchor(top: headerLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .topOnly(60))
        subTextLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .topOnly(15))
    }
}

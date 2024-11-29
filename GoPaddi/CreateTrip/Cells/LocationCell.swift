//
//  LocationCell.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import UIKit
final class LocationCell: BaseTableViewCell {
    
    let tripNameLabel: Label = {
        let label = Label(font: .satoshiBold(size: 16))
        label.textColor = .hex1D2433
        label.text = "Bahamas Family Trip"
        return label
    }()

    let locationIcon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "location_filled_icon"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let countryLabel: Label = {
        let label = Label(font: .satoshiBold(size: 16))
        label.text = "Lagos, Nigeria"
        label.textColor = .hex1D2433
        return label
    }()
    
    let airportNameLabel: Label = {
        let label = Label(font: .satoshiMedium())
        label.text = "Muritala Muhammed"
        label.textColor = .hex676E7E
        return label
    }()
    
    let flagIcon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "flag_one_icon"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let countryAbbrLabel: Label = {
        let label = Label(font: .satoshiMedium())
        label.text = "NG"
        label.textColor = .hex676E7E
        label.textAlignment = .center
        return label
    }()
    
    func configure(with data: LocationEntity) {
        countryLabel.text = data.countryName
        airportNameLabel.text = data.airport
        countryAbbrLabel.text = data.countrAbbr
        flagIcon.image = UIImage(named: data.flag)
    }
    
    override func setup() {
        super.setup()
        contentView.addSubviews(locationIcon, countryLabel, airportNameLabel, flagIcon, countryAbbrLabel)
        
        locationIcon.placeAtLeftCenterOf(centerY: contentView.centerYAnchor, leading: contentView.leadingAnchor, margin: .leftOnly(20))
        countryLabel.anchor(top: locationIcon.topAnchor, leading: locationIcon.trailingAnchor, margin: .topLeftOnly(-9, 10))
        airportNameLabel.anchor(leading: locationIcon.trailingAnchor,bottom: locationIcon.bottomAnchor, margin: .bottomLeftOnly(-9, 10))
        
        flagIcon.anchor(top: contentView.topAnchor, trailing: contentView.trailingAnchor, margin: .topRightOnly(25, 20))
        
        countryAbbrLabel.anchor(top: flagIcon.bottomAnchor, trailing: flagIcon.trailingAnchor, margin: .topRightOnly(7, 0))
    }
}

struct LocationEntity : Codable {
    let countryName: String
    let airport: String
    let flag: String
    let countrAbbr: String
}

struct LocationData: Codable {
    let data: [LocationEntity]
}


//
//  PlannedTripCell.swift
//  GoPaddi
//
//  Created by Abdullah on 27/11/2024.
//

import UIKit

final class PlannedTripCell: BaseTableViewCell {
    
    let tripNameLabel: Label = {
        let label = Label(font: .satoshiBold(size: 16))
        label.textColor = .hex1D2433
        label.text = "Bahamas Family Trip"
        return label
    }()
    
    let dateLabel: Label = {
        let label = Label( font: .satoshiMedium())
        label.textColor = .hex1D2433
        label.text = "19th April 2024"
        return label
    }()
    
    let timeLabel: Label = {
        let label = Label( font: .satoshiMedium())
        label.textColor = .hex676E7E
        label.text = "5 days"
        return label
    }()
    
    let viewBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("View", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .satoshiMedium()
        btn.backgroundColor = .hex0D6EFD
        btn.layer.cornerRadius = 4
        return btn
    }()
    
    let tripImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "paris_image"))
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 6
        return img
    }()
    
    let imgContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let gradientCardView: GradientCardView = {
        let view = GradientCardView()
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.hexE4E7EC.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var verticalStackView: VerticalStackView = {
        let stack = VerticalStackView(arrangedSubviews: [tripImage,viewBtn])
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 12
        return stack
    }()
    
    func configure(with data: TripEntity) {
        tripNameLabel.text = data.tripName
    }
    
    override func setup() {
        super.setup()
        contentView.addSubview(containerView)
        containerView.fillUpSuperview(margin: .init(allEdges: 12))
        
        containerView.addSubviews(viewBtn, dateLabel, timeLabel, tripNameLabel,imgContainer)
        viewBtn.anchor(leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, margin: .init(top: 0, left: 15, bottom: 15, right: 15), size: .init(width: 0, height: 55) )

        dateLabel.anchor(leading: containerView.leadingAnchor, bottom: viewBtn.topAnchor, margin: .bottomLeftOnly(15, 15))

        timeLabel.anchor( bottom: viewBtn.topAnchor, trailing: containerView.trailingAnchor, margin: .bottomRightOnly(15, 15))

        tripNameLabel.anchor(leading: containerView.leadingAnchor, bottom: dateLabel.topAnchor, trailing: containerView.trailingAnchor, margin: .init(top: 0, left: 15, bottom: 13, right: 15))

        imgContainer.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: tripNameLabel.topAnchor, trailing: containerView.trailingAnchor, margin: .init(allEdges: 15))
        
        imgContainer.addSubview(tripImage)
        tripImage.fillUpSuperview()
        
        tripImage.addSubview(gradientCardView)
        gradientCardView.anchor(top: tripImage.topAnchor, trailing: tripImage.trailingAnchor, margin: .topRightOnly(15, 15), size: .init(width: 100, height: 38))
    }
}


final class EmptyCell: BaseTableViewCell {
    
    let emptyLabel: Label = {
        let label = Label(font: .satoshiMedium(size: 16))
        label.textAlignment = .center
        return label
    }()
    
    func configure(with text: String) {
        emptyLabel.text = text
    }
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        contentView.addSubviews(emptyLabel)
        emptyLabel.fillUpSuperview()
    }
}


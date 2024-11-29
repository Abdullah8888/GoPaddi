//
//  GradientCardView.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import UIKit

final class GradientCardView: UIView {

    let titleLabel: Label = {
        let label = Label( font: .satoshiMedium())
        label.textColor = .white
        label.text = "Paris"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        setupCardStyle()
        setupLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        setupCardStyle()
        setupLabel()
    }

    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
    
        gradientLayer.colors = [
            UIColor.lightGray.withAlphaComponent(0.9).cgColor,
            UIColor.gray.cgColor
        ]
     
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupCardStyle() {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }

    private func setupLabel() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.sublayers?.first?.frame = self.bounds
    }
}

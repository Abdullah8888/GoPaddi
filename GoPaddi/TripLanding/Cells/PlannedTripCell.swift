//
//  PlannedTripCell.swift
//  GoPaddi
//
//  Created by Abdullah on 27/11/2024.
//

import UIKit

final class PlannedTripCell: BaseTableViewCell {
    
//    private let headerLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Custom Cell"
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.textColor = .black
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    let headerLabel: Label = {
        let label = Label(padding: .leftOnly(15), font: .satoshiBold(size: 20))
        label.textColor = .hex1D2433
        return label
    }()
    
    func configure(with text: String) {
        headerLabel.text = text
    }
    
    override func setup() {
        super.setup()
        contentView.addSubviews(headerLabel)
        headerLabel.fillUpSuperview()
    }
}

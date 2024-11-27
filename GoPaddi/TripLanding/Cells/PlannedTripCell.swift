//
//  PlannedTripCell.swift
//  GoPaddi
//
//  Created by Abdullah on 27/11/2024.
//

import UIKit

final class PlannedTripCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom Cell"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(headerLabel)
        headerLabel.fillUpSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String) {
        headerLabel.text = text
    }
}

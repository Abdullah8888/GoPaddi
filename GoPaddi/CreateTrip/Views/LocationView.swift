//
//  CreateTripView.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import UIKit

protocol LocationViewDelegate: AnyObject {
    func onSelectedItem(locationEntity: LocationEntity)
}

final class LocationView: BaseView {
    
    let titleLabel: Label = {
        let label = Label( font: .satoshiMedium())
        label.textColor = .hex647995
        label.text = "Please select a city"
        return label
    }()
    
    let cityTextField: TextField = {
        let textField = TextField()
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.hex0D6EFD.cgColor
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 4
        textField.font = .satoshiMedium(size: 16)
        textField.textColor = .hex1D2433
        return textField
    }()
    
    let locationCell = String(describing: LocationCell.self)
    lazy var tableView: UITableView = {
        let tableView =  UITableView(frame: .zero)
        tableView.register(LocationCell.self, forCellReuseIdentifier: locationCell)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var allLocations: [LocationEntity] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    var filteredLocations: [LocationEntity] = []
    
    var delegate: LocationViewDelegate?
    
    override func setup() {
        super.setup()
        addSubviews(titleLabel, cityTextField, tableView)
        
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, margin: .topLeftOnly(35, 20))
        
        cityTextField.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 65))
        
        tableView.anchor(top: cityTextField.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        cityTextField.addTarget(self, action: #selector(cityTextFieldDidChange(_:)), for: .editingChanged)
        
        filteredLocations = allLocations
    }
    
    @objc private func cityTextFieldDidChange(_ textField: UITextField) {
        let typedText = textField.text ?? ""
        debugPrint("User typed: \(typedText)")
        if typedText.isEmpty {
            filteredLocations = allLocations
        } else {
            filteredLocations = allLocations.filter { $0.countryName.lowercased().contains(typedText.lowercased()) }
        }
        
        // Reload the table view
        tableView.reloadData()
    }
}


extension LocationView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: locationCell, for: indexPath) as? LocationCell else {
            return UITableViewCell()
        }
        cell.configure(with: filteredLocations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = filteredLocations[indexPath.row]
        debugPrint("selectedLocation is \(selectedLocation)")
        delegate?.onSelectedItem(locationEntity: selectedLocation)
    }
}

extension LocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
}

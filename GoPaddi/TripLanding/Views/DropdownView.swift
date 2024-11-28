//
//  DropdownView.swift
//  GoPaddi
//
//  Created by Abdullah on 28/11/2024.
//

import UIKit

final class DropdownView: UIView {
    
    let dropDownCell = String(describing: DropDownCell.self)
    
    private lazy var dropdownButton: UIButton = {
        let button = UIButton()
        button.setTitle("Planned Trips", for: .normal)
        button.titleLabel?.font = .satoshiBold()
        button.setTitleColor(.hex1D2433, for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        return button
    }()
    
    private lazy var dropdownTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 8
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.separatorInset = .zero
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DropDownCell.self, forCellReuseIdentifier: dropDownCell)
        return tableView
    }()
    
    private var dropdownItems: [String] = []
    private var isDropdownVisible = false
    var onItemSelected: ((String) -> Void)?

    init(items: [String]) {
        self.dropdownItems = items
        super.init(frame: .zero)
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewStartScrolling), name: NSNotification.Name("TableViewDidStartScrolling"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NotificationNames.tableViewDidStartScrolling), object: nil)
    }
    
    @objc private func handleTableViewStartScrolling(notification: Notification) {
        if let _ = notification.object as? UITableView {
            if isDropdownVisible {
                removeDropdownTableView()
                isDropdownVisible.toggle()
            }
        }
    }

    private func setupViews() {
        
        addSubview(dropdownButton)
        dropdownButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropdownButton.topAnchor.constraint(equalTo: topAnchor),
            dropdownButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            dropdownButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            dropdownButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func toggleDropdown() {
        if isDropdownVisible {
            removeDropdownTableView()
        } else {
            addDropdownTableView()
        }
        isDropdownVisible.toggle()
    }
    
    private func addDropdownTableView() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        let buttonFrame = self.convert(dropdownButton.frame, to: window)
        
        window.addSubview(dropdownTableView)
        dropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropdownTableView.topAnchor.constraint(equalTo: window.topAnchor, constant: buttonFrame.maxY + 8),
            dropdownTableView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: buttonFrame.minX),
            dropdownTableView.widthAnchor.constraint(equalToConstant: buttonFrame.width),
            dropdownTableView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func removeDropdownTableView() {
        dropdownTableView.removeFromSuperview()
    }
    
    func setItems(_ items: [String]) {
        dropdownItems = items
        dropdownTableView.reloadData()
    }
}

extension DropdownView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropdownItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dropDownCell, for: indexPath) as? DropDownCell else {
            return UITableViewCell()
        }
        cell.itemLabel.text = dropdownItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = dropdownItems[indexPath.row]
        dropdownButton.setTitle(selectedItem, for: .normal)
        removeDropdownTableView()
        isDropdownVisible = false
        onItemSelected?(selectedItem)
    }
}

final class DropDownCell: BaseTableViewCell {
    
    let itemLabel: Label = {
        let label = Label(padding: .init(allEdges: 13), font: .satoshiRegular())
        label.textColor = .hex1D2433
        return label
    }()

    override func setup() {
        super.setup()
        contentView.addSubview(itemLabel)
        itemLabel.fillUpSuperview()
    }
}


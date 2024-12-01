//
//  DropdownView.swift
//  GoPaddi
//
//  Created by Abdullah on 28/11/2024.
//

import UIKit

final class DropdownView: UIView {
    
    let dropDownCell = String(describing: DropDownCell.self)
    
    lazy var dropdownButton: UIButton = {
        let button = UIButton()
        button.setTitle("Planned Trips", for: .normal)
        button.titleLabel?.font = .satoshiBold()
        button.setTitleColor(.hex1D2433, for: .normal)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        return button
    }()
    
    private lazy var dropdownTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 8
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.separatorInset = .zero
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(DropDownCell.self, forCellReuseIdentifier: dropDownCell)
        return tableView
    }()
    
    let caretDownIcon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "caret_down_icon"))
        img.contentMode = .center
        return img
    }()
    
    private var dropdownItems: [String] = []
    private var isDropdownVisible = false
    private var selectedIndexPath: IndexPath?
    var onItemSelected: ((String) -> Void)?
    
    init(items: [String]) {
        self.dropdownItems = items
        super.init(frame: .zero)
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewStartScrolling), name: NSNotification.Name("TableViewDidStartScrolling"), object: nil)
        preselectIndex(index: 0)
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
        dropdownButton.fillUpSuperview()

        dropdownButton.addSubview(caretDownIcon)
        caretDownIcon.anchor(top: dropdownButton.topAnchor, bottom: dropdownButton.bottomAnchor, trailing: dropdownButton.trailingAnchor, margin: .rightOnly(7), size: .init(width: 20, height: 0))
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
            dropdownTableView.bottomAnchor.constraint(equalTo: window.topAnchor, constant: buttonFrame.minY + 8),
            dropdownTableView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: buttonFrame.minX),
            dropdownTableView.widthAnchor.constraint(equalToConstant: buttonFrame.width),
            dropdownTableView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let text = dropdownButton.titleLabel?.text
        if let index = dropdownItems.firstIndex(of: text!) {
            preselectIndex(index: index)
        }
    }
    
    private func removeDropdownTableView() {
        dropdownTableView.removeFromSuperview()
    }
    
    func setItems(_ items: [String]) {
        dropdownItems = items
        dropdownTableView.reloadData()
    }
    
    func preselectIndex(index: Int) {
        let preselectedIndex = index
                selectedIndexPath = IndexPath(row: preselectedIndex, section: 0)
        dropdownTableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
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
        if indexPath == selectedIndexPath {
            cell.setItemSelected()
        } else {
            cell.unSetItemSelected()
        }
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
    
    let checkIcon: UIImageView = {
        let img = UIImageView(image: UIImage(named: "check_icon"))
        img.contentMode = .scaleAspectFill
        img.isHidden = true
        return img
    }()

    override func setup() {
        super.setup()
        contentView.addSubviews(itemLabel, checkIcon)
        itemLabel.fillUpSuperview()
        checkIcon.placeAtRightCenterOf(centerY: contentView.centerYAnchor,trailing: contentView.trailingAnchor, margin: .rightOnly(10))
    }
    
    func setItemSelected() {
        itemLabel.font = .satoshiBold()
        itemLabel.textColor = .white
        backgroundColor = .hex0D6EFD
        checkIcon.isHidden = false
    }
    
    func unSetItemSelected() {
        itemLabel.font = .satoshiRegular()
        itemLabel.textColor = .hex1D2433
        backgroundColor = .white
        checkIcon.isHidden = true
    }
}


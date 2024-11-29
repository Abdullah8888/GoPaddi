//
//  TripView.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import UIKit

final class TripLandingView: BaseView {
    let plannedTripCell = String(describing: PlannedTripCell.self)
    let emptyCell = String(describing: EmptyCell.self)
    lazy var tableView: UITableView = {
        let tableView =  UITableView(frame: .zero)
        tableView.register(PlannedTripCell.self, forCellReuseIdentifier: plannedTripCell)
        tableView.register(EmptyCell.self, forCellReuseIdentifier: emptyCell)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var tripHeaderView: TripHeaderView?
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubview(tableView)
        tableView.fillUpSuperview()
    }
    
    var items: [Int] = [1,2] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateContentHeight()
    }
    
    func setTripHeaderView() {
        tripHeaderView = TripHeaderView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: contentHeight! - 20))
        tableView.tableHeaderView = tripHeaderView
        tableView.tableHeaderView?.layoutIfNeeded()
//        if items.isEmpty {
//            //showPlaceholderView(message: "Empty")
//            tripHeaderView?.showEmptyView(message: "Empty")
//        }
    }
    
}

extension TripLandingView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if items.isEmpty {
//            //showPlaceholderView(message: "Empty")
//            tableView.setEmptyView("Empty")
//        }
//        else {
//            tableView.backgroundView = nil
//            tableView.reloadData()
//        }
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if items.count == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: emptyCell, for: indexPath) as? EmptyCell else {
                return UITableViewCell()
            }
            cell.configure(with: "Empty")
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: plannedTripCell, for: indexPath) as? PlannedTripCell else {
                return UITableViewCell()
            }
            cell.configure(with: "Row \(indexPath.row + 1)")
            //cell.backgroundColor = (indexPath.row + 1) % 2 == 0  ? .red : .blue
            return cell
        }
    }
}

extension TripLandingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        370
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(NotificationNames.tableViewDidStartScrolling), object: tableView)
    }
}

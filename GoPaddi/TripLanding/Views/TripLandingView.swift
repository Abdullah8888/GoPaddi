//
//  TripView.swift
//  GoPaddi
//
//  Created by Abdullah on 26/11/2024.
//

import UIKit

final class TripLandingView: BaseView {
    let plannedTripCell = String(describing: PlannedTripCell.self)
    lazy var tableView: UITableView = {
        let tableView =  UITableView(frame: .zero)
        tableView.register(PlannedTripCell.self, forCellReuseIdentifier: plannedTripCell)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var tripHeaderView: TripHeaderView?
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        addSubview(tableView)
        tableView.fillUpSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateContentHeight()
    }
    
    func setTripHeaderView() {
        tripHeaderView = TripHeaderView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: contentHeight!))
        tableView.tableHeaderView = tripHeaderView
        tableView.tableHeaderView?.layoutIfNeeded()
    }
}

extension TripLandingView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: plannedTripCell, for: indexPath) as? PlannedTripCell else {
            return UITableViewCell()
        }
        cell.configure(with: "Row \(indexPath.row + 1)")
        cell.backgroundColor = (indexPath.row + 1) % 2 == 0  ? .red : .blue
        return cell
    }
}

extension TripLandingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(NotificationNames.tableViewDidStartScrolling), object: tableView)
    }
}

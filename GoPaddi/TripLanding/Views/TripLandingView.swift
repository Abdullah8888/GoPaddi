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
    
    var items: [TripEntity]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    func setTripHeaderView() {
        tripHeaderView = TripHeaderView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: 715))
        tableView.tableHeaderView = tripHeaderView
        tableView.tableHeaderView?.layoutIfNeeded()
    }
    
}

extension TripLandingView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if let count = items?.count {
            return count >= 1 ? count : 1
        }
        else {
            return 1
        }
        
        //return items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        
        guard let items = items else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: emptyCell, for: indexPath) as? EmptyCell else {
                return UITableViewCell()
            }
            cell.configure(with: "Empty")
            return cell
        }

        if items.count >= 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: plannedTripCell, for: indexPath) as? PlannedTripCell else {
                return UITableViewCell()
            }
            cell.configure(with: items[indexPath.row])
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: emptyCell, for: indexPath) as? EmptyCell else {
                return UITableViewCell()
            }
            cell.configure(with: "Empty")
            return cell
        }
        
//        guard let items = items else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: emptyCell, for: indexPath) as? EmptyCell else {
//                return UITableViewCell()
//            }
//            cell.configure(with: "Empty")
//            return cell
//        }
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: plannedTripCell, for: indexPath) as? PlannedTripCell else {
//            return UITableViewCell()
//        }
//        cell.configure(with: items[indexPath.row])
//        return cell
      
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

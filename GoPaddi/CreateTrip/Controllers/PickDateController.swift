//
//  PickDateController.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import UIKit
import FSCalendar

final class PickDateController: MainBaseController {

    var calendar: FSCalendar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Date")
        view.backgroundColor = .white
        
        // In loadView or viewDidLoad
//        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: Constant.screenHeight))
//        calendar.dataSource = self
//        calendar.delegate = self
//        view.addSubview(calendar)
//        self.calendar = calendar
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupView() {
        calendar = FSCalendar(frame: .zero)
        view.addSubview(calendar!)
        calendar!.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        calendar?.dataSource = self
        calendar?.delegate = self
    }
}

extension PickDateController: FSCalendarDataSource {
    
}

extension PickDateController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        debugPrint(date)
    }
    
}

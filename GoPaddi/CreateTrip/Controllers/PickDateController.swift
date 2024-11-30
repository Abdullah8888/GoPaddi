//
//  PickDateController.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import UIKit
import FSCalendar

enum SetDateFor {
    case startDate, endDate
}

final class PickDateController: MainBaseController {

    var calendar: FSCalendar?
    let chooseDateView: ChooseDateView = {
        let view = ChooseDateView()
        return view
    }()
    var setDateFor: SetDateFor = .startDate
    
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
        
        view.addSubview(chooseDateView)
        chooseDateView.anchor(leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: 165))
        
        view.bringSubviewToFront(calendar!)
        calendar?.isHidden = true
        
        chooseDateView.startDateView.onClick(completion: weakify({ strongSelf in
            strongSelf.calendar?.isHidden = false
            strongSelf.setDateFor = .startDate
            strongSelf.chooseDateView.isHidden = true
        }))
        
        chooseDateView.endDateView.onClick(completion: weakify({ strongSelf in
            strongSelf.calendar?.isHidden = false
            strongSelf.setDateFor = .endDate
            strongSelf.chooseDateView.isHidden = true
        }))
        
        chooseDateView.chooseDateBtn.onClick(completion: weakify({ strongSelf in
            if let startDate  = strongSelf.chooseDateView.startDateLabel.text,
               let endDate  = strongSelf.chooseDateView.endDateLabel.text {
                if startDate.isEmpty && endDate.isEmpty {
                    strongSelf.showToast(message: "Please make sure both dates are selected")
                }
                else {
                    let vc = EnterTripDetailsController(nibName: Constant.enterTripDetailsController, bundle: nil)
                    vc.modalPresentationStyle = .custom
                    let customTransitionDelegate = CustomModalTransitioningDelegate()
                    vc.transitioningDelegate = customTransitionDelegate
                    vc.delegate = self
                    strongSelf.navigationController?.present(vc, animated: true)
                }
            }
            else {
                strongSelf.showToast(message: "Please make sure both dates are selected")
            }
        }))
    }
}

extension PickDateController: EnterTripDetailsControllerDelegate {
    func didFinishPlanningTrip() {
        navigationController?.dismiss(animated: true)
    }
}

extension PickDateController: FSCalendarDataSource {
    
}

extension PickDateController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if setDateFor == .startDate {
            chooseDateView.startDateLabel.text = date.dateOnly()
        }
        if setDateFor == .endDate {
            chooseDateView.endDateLabel.text = date.dateOnly()
        }
        calendar.isHidden = true
        chooseDateView.isHidden = false
    }
    
}

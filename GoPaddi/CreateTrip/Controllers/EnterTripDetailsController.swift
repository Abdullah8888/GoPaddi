//
//  EnterTripDetailsController.swift
//  GoPaddi
//
//  Created by Abdullah on 29/11/2024.
//

import UIKit
import Combine

protocol EnterTripDetailsControllerDelegate: AnyObject {
    func didFinishPlanningTrip()
}

final class EnterTripDetailsController: UIViewController {

    @IBOutlet weak var cancelIcon: UIImageView!
    
    @IBOutlet weak var mainContentView: UIView!
    
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tripNameTextField: UITextField!
    
    @IBOutlet weak var travelStyleView: UIView!
    
    @IBOutlet weak var travelStyleLabel: UILabel!
    
    @IBOutlet weak var travelDescriptionTextView: UITextView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    weak var delegate: EnterTripDetailsControllerDelegate?
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentHeightConstraint.constant = Constant.screenHeight - 150
        setupView()
        cancelIcon.onClick(completion: weakify({ strongSelf in
            strongSelf.delegate?.didFinishPlanningTrip()
        }))
        startListners()
    }
    
    func setupView() {
        tripNameTextField.layer.borderColor = UIColor.hex98A2B3.cgColor
        travelStyleView.layer.borderColor = UIColor.hex98A2B3.cgColor
        travelDescriptionTextView.layer.borderColor = UIColor.hex98A2B3.cgColor
        
        nextBtn.titleLabel?.font = .satoshiMedium()
        nextBtn.isEnabled = false
        nextBtn.alpha = 0.5
    }
    
    @IBAction func onTapNextBtn(_ sender: UIButton) {
        
    }
    
    func startListners() {
        Publishers.CombineLatest(
                   tripNameTextField.publisher,
                   travelDescriptionTextView.publisher
                   //travelStyleLabel.publisher
               )
               .map { tripName, travelDescription in
                   !(tripName?.isEmpty ?? true) &&
                   !(travelDescription?.isEmpty ?? true)
//                   !((tripStyle?.isEmpty ?? true) && (tripStyle != "Select your travel style") )
               }
               .receive(on: DispatchQueue.main)
               .sink(receiveValue: weakify({ strongSelf, isValid in
                   strongSelf.nextBtn.isEnabled = isValid
                   strongSelf.nextBtn.alpha = isValid ? 1.0 : 0.5
               }))
               .store(in: &cancellables)
    }
}


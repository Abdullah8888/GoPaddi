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

final class EnterTripDetailsController: MainBaseController {

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
    
    var viewModel: CreateTripViewModel?
    
    weak var createTripCoordinator: CreateTripCoordinator?
    
    var selectedTravelStyle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentHeightConstraint.constant = Constant.screenHeight - 150
        setupView()
        cancelIcon.onClick(completion: weakify({ strongSelf in
            //strongSelf.createTripCoordinator?.dismiss()
            strongSelf.createTripCoordinator?.dismiss(animated: false)
            strongSelf.createTripCoordinator?.goToRoot(animated: false)
        }))
        startListners()
        responseListeners()
    }
    
    func setupView() {
        tripNameTextField.layer.borderColor = UIColor.hex98A2B3.cgColor
        travelStyleView.layer.borderColor = UIColor.hex98A2B3.cgColor
        travelDescriptionTextView.layer.borderColor = UIColor.hex98A2B3.cgColor
        travelDescriptionTextView.textColor = .hex98A2B3
        
        nextBtn.titleLabel?.font = .satoshiMedium()
        nextBtn.isEnabled = false
        nextBtn.alpha = 0.5
        
        let dropdownView = DropdownView(items: ["Solo", "Couple", "Family", "Group"])
        dropdownView.dropdownButton.setTitle("Select your travel style", for: .normal)
        dropdownView.dropdownButton.setTitleColor(.hex98A2B3, for: .normal)
        dropdownView.dropdownButton.titleLabel?.font = .satoshiMedium()
        dropdownView.onItemSelected = weakify({ strongSelf, item in
            //strongSelf.selectedTravelStyle = item
            //strongSelf.viewModel?.selectedTravelStyle.send(item)
            strongSelf.viewModel?.selectedTravelStyle = item
        })
        
        travelStyleView.addSubview(dropdownView)
        dropdownView.fillUpSuperview(margin: .init(allEdges: 10))
    }
    
    @IBAction func onTapNextBtn(_ sender: UIButton) {
        showToast(message: "Processing ...")
        Task {
            await viewModel?.createTrip(tripName: viewModel?.tripName ?? "", tripStyle: selectedTravelStyle ?? "", tripDescription: viewModel?.tripDescription ?? "")
        }
    }
    
    func startListners() {
        Publishers.CombineLatest3(
                   tripNameTextField.publisher,
                   travelDescriptionTextView.publisher,
                   viewModel!.$selectedTravelStyle
               )
               .map { tripName, travelDescription, tripStyle in
                   !(tripName?.isEmpty ?? true) &&
                   !(travelDescription?.isEmpty ?? true) &&
                   !(tripStyle?.isEmpty ?? true)
               }
               .receive(on: DispatchQueue.main)
               .sink(receiveValue: weakify({ strongSelf, isValid in
                   strongSelf.nextBtn.isEnabled = isValid
                   strongSelf.nextBtn.alpha = isValid ? 1.0 : 0.5
                   
                   if isValid {
                       strongSelf.viewModel?.tripName = strongSelf.tripNameTextField.text
                       strongSelf.selectedTravelStyle = strongSelf.travelDescriptionTextView.text
                       strongSelf.viewModel?.tripDescription = strongSelf.viewModel?.selectedTravelStyle
                   }
               }))
               .store(in: &cancellables)
    }
    
    func setInput() {
        viewModel?.tripName = tripNameTextField.text
        viewModel?.selectedTravelStyle = travelStyleLabel.text
        viewModel?.tripDescription = travelDescriptionTextView.text
    }
    
    func responseListeners() {
        viewModel?.tripEntityResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: weakify({ strongSelf, completion in
                switch completion {
                case .finished:
                    debugPrint("tripEntityResponse error")
                case .failure(let error):
                    debugPrint("tripEntityResponse is \(error)")
                    
                }
                
            }) , receiveValue: weakify({ strongSelf, data in
                
                debugPrint("data => \(data)")
                
                debugPrint("show success page")
                
                strongSelf.showToast(message: "Successfully created")
                
                NotificationCenter.default.post(name: NSNotification.Name(NotificationNames.didEndPlanningTrip), object: nil)
                
                strongSelf.createTripCoordinator?.dismiss(animated: false)
                strongSelf.createTripCoordinator?.goToRoot()
                
            }))
            .store(in: &subscriptions)
        
        viewModel?.errResponse
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: weakify({ strongSelf, error in
                strongSelf.showToast(message: "\(error.composeErrMessage)")
            }))
            .store(in: &subscriptions)
    }
}


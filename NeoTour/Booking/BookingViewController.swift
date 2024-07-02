//
//  BookingViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 29/06/2024.
//
import UIKit
import Combine

class BookingViewController: UIViewController {
    private let bookingView = BookingView()
    private let stepperViewModel = StepperViewModel()
    private let bookingViewModel = BookingViewModel()
    private let tour: TourModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(tour: TourModel) {
        self.tour = tour
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = bookingView
        bookingView.customStepper.viewModel = stepperViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        bindViewModel()
        configureStepper()
    }
    
    private func setupTargets() {
        bookingView.phoneTextField.leftButton.addTarget(self, action: #selector(flagTapped), for: .touchUpInside)
        bookingView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        bookingView.customStepper.decrementButton.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)
        bookingView.customStepper.incrementButton.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
        
        bookingView.phoneTextField.textField.addTarget(self, action: #selector(phoneNumberChanged(_:)), for: .editingChanged)
        bookingView.commentTextField.textField.addTarget(self, action: #selector(commentChanged(_:)), for: .editingChanged)
    }
    
    private func bindViewModel() {
        bookingViewModel.isFormValid
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                self?.bookingView.submitButton.isEnabled = isValid
                self?.bookingView.submitButton.alpha = isValid ? 1.0 : 0.5
            }
            .store(in: &cancellables)
    }
    
    private func configureStepper() {
        stepperViewModel.value = 1
        stepperViewModel.maxValue = tour.bookingLimit
        stepperViewModel.onValueChange = { [weak self] value in
            self?.bookingView.customStepper.valueLabel.text = "\(value)"
        }
        bookingView.customStepper.viewModel = stepperViewModel
    }
    
    @objc private func phoneNumberChanged(_ textField: UITextField) {
        bookingViewModel.phoneNumber = textField.text ?? ""
    }
    
    @objc private func commentChanged(_ textField: UITextField) {
        bookingViewModel.comment = textField.text ?? ""
    }
    
    @objc private func flagTapped() {
        let countrySelectionVC = CountrySelectionViewController()
        countrySelectionVC.didSelectCountry = { [weak self] country in
            self?.bookingView.phoneTextField.leftButton.setTitle(country.flag, for: .normal)
            self?.bookingView.phoneTextField.countryCode = country.code
        }
        countrySelectionVC.modalPresentationStyle = .popover
        
        if let popoverPresentationController = countrySelectionVC.popoverPresentationController {
            popoverPresentationController.sourceView = bookingView.phoneTextField.leftButton
            popoverPresentationController.sourceRect = bookingView.phoneTextField.leftButton.bounds
            popoverPresentationController.permittedArrowDirections = .left
            popoverPresentationController.delegate = self
        }
        
        present(countrySelectionVC, animated: true, completion: nil)
    }
    
    @objc private func submitTapped() {
        bookingViewModel.createBooking(tourId: tour.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Booking successful: \(response)")
                    self?.presentPopup(title: "Success", message: "Booking successful!")
                case .failure(let error):
                    print("Booking failed: \(error.localizedDescription)")
                    self?.presentPopup(title: "Error", message: error.localizedDescription.description)
                }
            }
        }
    }
    
    private func presentPopup(title: String, message: String) {
        let popupVC = PopupViewController(title: title, message: message, buttonTitle: "OK")
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.onDismiss = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        present(popupVC, animated: true, completion: nil)
    }
    
    @objc private func decrementValue() {
        stepperViewModel.decrement()
    }
    
    @objc private func incrementValue() {
        stepperViewModel.increment()
    }
}

extension BookingViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

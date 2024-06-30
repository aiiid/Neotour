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
    private var cancellables: Set<AnyCancellable> = []

    override func loadView() {
        view = bookingView
        bookingView.customStepper.viewModel = stepperViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        bindViewModel()
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
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("BookingViewControllerDismissed"), object: nil)
        }
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

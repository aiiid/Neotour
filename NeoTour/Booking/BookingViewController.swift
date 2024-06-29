//
//  BookingViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 29/06/2024.
//

import UIKit

class BookingViewController: UIViewController {
    private let bookingView = BookingView()
    
    override func loadView() {
        view = bookingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
    }
    
    private func setupTargets() {
        bookingView.phoneTextField.leftButton.addTarget(self, action: #selector(flagTapped), for: .touchUpInside)
        bookingView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc private func flagTapped() {
        print("flag tapped")
    }
    
    @objc private func submitTapped() {
        print("SUBMIT")
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("BookingViewControllerDismissed"), object: nil)
        }
    }
}

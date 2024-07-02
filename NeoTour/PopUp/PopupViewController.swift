//
//  PopupViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//

import UIKit

class PopupViewController: UIViewController {
    private let popupView = PopupView()
    var onDismiss: (() -> Void)?
    
    override func loadView() {
        view = popupView
    }
    
    init(title: String? = nil, message: String, buttonTitle: String? = "Ok") {
        super.init(nibName: nil, bundle: nil)
        popupView.titleLabel.text = title
        popupView.messageLabel.text = message
        popupView.submitButton.setTitle(buttonTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
    }
    
    private func setupTargets() {
        popupView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc private func submitTapped() {
        dismiss(animated: true) { [weak self] in
                   self?.onDismiss?()
               }
    }
}

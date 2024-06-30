//
//  PopupViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//

import UIKit

class PopupViewController: UIViewController {
    private let popupView = PopupView()
    
    override func loadView() {
        view = popupView
    }
    
    init(title: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        popupView.titleLabel.text = title
//        self.message = message
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
        print("OK")
        dismiss(animated: true)
    }
}

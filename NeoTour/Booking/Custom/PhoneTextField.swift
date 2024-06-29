//
//  CountryTextField.swift
//  NeoTour
//
//  Created by Ai Hawok on 29/06/2024.
//
import UIKit
import SnapKit

class PhoneTextField: UITextField {
    
    let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🇰🇿", for: .normal)
        return button
    }()
    
    var countryCode: String = "+7" {
        didSet {
            placeholder = countryCode
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        keyboardType = .phonePad // Only allow phone numbers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftViewContainer.addSubview(leftButton)
        self.leftView = leftViewContainer
        self.leftViewMode = .always
        
        placeholder = countryCode
        borderStyle = .roundedRect
        layer.cornerRadius = 25
        tintColor = Constants.Colors.primaryColor
        
        leftButton.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    @objc private func leftButtonTapped() {
        guard let parentViewController = self.parentViewController else { return }
        
        let countrySelectionVC = CountrySelectionViewController()
        countrySelectionVC.didSelectCountry = { [weak self] country in
            self?.leftButton.setTitle(country.flag, for: .normal)
            self?.countryCode = country.code
        }
        
        countrySelectionVC.modalPresentationStyle = .popover
        
        if let popoverPresentationController = countrySelectionVC.popoverPresentationController {
            popoverPresentationController.sourceView = leftButton
            popoverPresentationController.sourceRect = leftButton.bounds
            popoverPresentationController.permittedArrowDirections = .left
            popoverPresentationController.delegate = self
        }
        
        parentViewController.present(countrySelectionVC, animated: true, completion: nil)
    }
}

extension PhoneTextField: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

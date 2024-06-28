//
//  BookingPopupView.swift
//  NeoTour
//
//  Created by Ai Hawok on 28/06/2024.
//
import UIKit
import SnapKit

class BookingPopupView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your info"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.text = "Lorem upsum UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        return textField
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = Constants.Colors.primaryColor
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionText)
        containerView.addSubview(nameTextField)
        containerView.addSubview(phoneNumberTextField)
        containerView.addSubview(submitButton)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(400)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionText.snp.bottom).offset(16)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(40)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(40)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalTo(containerView).inset(16)
            make.height.equalTo(44)
        }
    }
}

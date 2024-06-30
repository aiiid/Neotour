//
//  CountryTextField.swift
//  NeoTour
//
//  Created by Ai Hawok on 29/06/2024.
//

import UIKit
import SnapKit

class PhoneTextField: UIView {
    
    var countryCode: String = "+7" {
        didSet {
            textField.placeholder = countryCode
        }
    }
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone number"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 50
        textField.tintColor = Constants.Colors.primaryColor
        textField.keyboardType = .phonePad
        return textField
    }()
    
    let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🇰🇿", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        updatePlaceholder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(subtitleLabel)
        addSubview(textField)
        setupTextField()
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    private func setupTextField() {
        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftViewContainer.addSubview(leftButton)
        textField.leftView = leftViewContainer
        textField.leftViewMode = .always
        
        leftButton.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    private func updatePlaceholder() {
            textField.placeholder = countryCode
        }
}

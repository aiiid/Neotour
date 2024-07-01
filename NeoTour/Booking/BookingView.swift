//
//  BookingPopupView.swift
//  NeoTour
//
//  Created by Ai Hawok on 28/06/2024.
//

import UIKit
import SnapKit

class BookingView: UIView {
    
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
        label.text = "To submit an application for a tour reservation, you need to fill in your information and select the number of people for the reservation"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = Constants.Colors.primaryColor
        button.tintColor = .white
        button.layer.cornerRadius = 25
        return button
    }()
    
    let phoneTextField = PhoneTextField()
    let commentTextField = CommentTextField()
    let customStepper = StepperView()
    
    let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        var edgeInset = 16
        var interInset = 16
        backgroundColor = .white
        addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(verticalStack)
        containerView.addSubview(submitButton)
        
        verticalStack.addArrangedSubview(descriptionText)
        verticalStack.addArrangedSubview(phoneTextField)
        verticalStack.addArrangedSubview(commentTextField)
        verticalStack.addArrangedSubview(customStepper)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).inset(8)
            make.leading.equalToSuperview().inset(edgeInset)
            make.height.equalTo(20)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(interInset)
            make.leading.trailing.equalToSuperview().inset(edgeInset)
            make.bottom.equalTo(submitButton.snp.top).offset(-50)
        }
        
        customStepper.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.leading.equalToSuperview()
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(containerView).inset(edgeInset)
            make.height.equalTo(50)
        }
    }
}

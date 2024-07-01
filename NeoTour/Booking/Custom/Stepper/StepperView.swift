//
//  CustomStepper.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//
import UIKit
import SnapKit

class StepperView: UIView {
    let stepperView = UIView()
    let personView = UIView()
    
    var viewModel: StepperViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of people"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .light)
        button.backgroundColor = Constants.Colors.primaryColor
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .light)
        button.backgroundColor = Constants.Colors.primaryColor
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let personIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.tintColor = .label
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let personLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    private func bindViewModel() {
        viewModel?.onValueChange = { [weak self] value in
            self?.valueLabel.text = "\(value)"
            self?.personLabel.text = "\(value)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(subtitleLabel)
        addSubview(infoStack)
        infoStack.addArrangedSubview(stepperView)
        infoStack.addArrangedSubview(personView)
        
        [valueLabel, decrementButton, incrementButton].forEach { stepperView.addSubview($0) }
        [personLabel, personIcon].forEach { personView.addSubview($0) }
        
        setupStepperView()
        setupPersonView()
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        infoStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupStepperView() {
        valueLabel.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        decrementButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(29)
            make.height.equalTo(36)
        }
        
        incrementButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(29)
            make.height.equalTo(36)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(decrementButton.snp.centerX)
            make.trailing.equalTo(incrementButton.snp.centerX)
            make.top.bottom.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        stepperView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(36)
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func setupPersonView() {
        personIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        personLabel.snp.makeConstraints { make in
            make.leading.equalTo(personIcon.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
        
        personView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.bottom.equalToSuperview()
        }
    }
}

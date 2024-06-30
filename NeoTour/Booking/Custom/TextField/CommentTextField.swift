//
//  NameTextField.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//

import UIKit
import SnapKit

class CommentTextField: UIView {
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Commentaries to Trip"
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
        textField.layer.borderColor = Constants.Colors.primaryColor.cgColor
        textField.tintColor = Constants.Colors.primaryColor
        textField.placeholder = "Write your wishes to trip..."
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(subtitleLabel)
        addSubview(textField)
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}

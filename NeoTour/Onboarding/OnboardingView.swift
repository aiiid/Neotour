//
//  OnboardingView.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import UIKit
import SnapKit

class OnboardingView: UIView {
    
    let letsGoButton: UIButton = {
        let button =  UIButton(type: .system)
        button.setTitle("Let's go", for: .normal)
        button.backgroundColor = Constants.Colors.primaryColor
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProDisplay-Regular", size: 36)
        text.text = "Winter Vacation Trips"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let descriptionText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SF-Pro-Text-Regular.otf", size: 36)
        text.text = """
        Enjoy your winter vacations with warmth
        and amazing sightseeing on the mountains.
        Enjoy the best experience with us!
        """
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let mainImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "OnboardingImage.png"))
        image.layer.cornerRadius = 25
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(letsGoButton)
        addSubview(mainImage)
        addSubview(titleText)
        addSubview(descriptionText)
        
        mainImage.snp.makeConstraints { make in
            make.width.equalTo(643)
            make.height.equalTo(480)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        titleText.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(283)
            make.height.equalTo(86)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(titleText.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(78)
        }
        
        letsGoButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionText.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(178)
            make.height.equalTo(53)
        }
    }
}

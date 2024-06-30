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
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Let's go"
        
        if let originalImage = UIImage(named: "arrowIcon") {
            let size = CGSize(width: 37, height: 40)
            let renderer = UIGraphicsImageRenderer(size: size)
            let resizedImage = renderer.image { _ in
                originalImage.draw(in: CGRect(origin: .zero, size: size))
            }
            configuration.image = resizedImage
        }

        configuration.imagePadding = 8
        configuration.baseBackgroundColor = Constants.Colors.primaryColor
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .large
        configuration.imagePlacement = .trailing
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
       
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProText-Bold", size: 36)
        text.text = "Winter Vacation Trips"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let descriptionText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        text.textColor = .label
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
        let imageView = UIImageView(image: UIImage(named: "onboardingImage.png"))
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
        }
        
        titleText.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-116)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(titleText.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        letsGoButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionText.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(150)
            make.height.equalTo(53)
        }
    }
}

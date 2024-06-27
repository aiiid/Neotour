//
//  DetailView.swift
//  NeoTour
//
//  Created by Ai Hawok on 26/06/2024.
//

import UIKit
import SnapKit

class DetailView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let mainImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "onboardingImage.png"))
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let infoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        return view
    }()
    
    let titleText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProText-Bold", size: 24)
        text.text = "Mount Fuji"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let locationText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        text.text = "Honshu, Japan"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let locationIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "mappin.and.ellipse")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProText-Semibold", size: 20)
        text.text = "Description"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let descriptionText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        text.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Dignissim eget amet viverra eget fames rhoncus.
        Eget enim venenatis enim porta egestas malesuada et.
        Consequat mauris lacus euismod montes.
        """
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let locationStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let descriptionStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let reviewsLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProText-Semibold", size: 20)
        text.text = "Reviews"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let reviewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("  \(name)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(mainImage)
        addSubview(infoView)
        
        [locationIcon, locationText].forEach {locationStack.addArrangedSubview($0)}
        [titleText, locationStack].forEach {titleStack.addArrangedSubview($0)}
        [descriptionLabel, descriptionText].forEach {descriptionStack.addArrangedSubview($0)}
        
        descriptionText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        locationIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
        
        [titleStack, locationStack, descriptionStack, reviewsLabel, reviewsTableView].forEach { infoView.addSubview($0) }
        
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.centerX.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.width.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview()
        }
        
        locationStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(16)
            
        }
        
        descriptionStack.snp.makeConstraints { make in
            make.top.equalTo(locationStack.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        reviewsLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionStack.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        reviewsTableView.snp.makeConstraints { make in
            make.top.equalTo(reviewsLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}

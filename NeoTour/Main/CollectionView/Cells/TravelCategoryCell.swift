//
//  TravelCategoryCell.swift
//  NeoTour
//
//  Created by Ai Hawok on 26/06/2024.
//

import UIKit

class TravelCategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "TravelCategory"
    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private lazy var circleIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "circle.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fillEqually
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
        backgroundColor = .purple
        verticalStackView.addArrangedSubview(categoryTitle)
        verticalStackView.addArrangedSubview(circleIcon)
        
        addSubview(verticalStackView)
        
        circleIcon.snp.makeConstraints { make in
            make.width.height.equalTo(10)
        }
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(title: String) {
        categoryTitle.text = title
    }
}

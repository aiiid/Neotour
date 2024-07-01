//
//  ReviewCell.swift
//  NeoTour
//
//  Created by Ai Hawok on 26/06/2024.
//
import UIKit
import SnapKit
import SDWebImage

class ReviewCell: UITableViewCell {
    static let reuseIdentifier = "ReviewCell"
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let reviewText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let reviewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    let userStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        contentView.addSubview(userStack)
        contentView.addSubview(verticalStack)
        
        userStack.addArrangedSubview(profileImage)
        userStack.addArrangedSubview(username)
        
        verticalStack.addArrangedSubview(reviewText)
        
        userStack.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(16)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(userStack.snp.bottom).offset(8)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
    
    public func configure(with review: Review) {
            username.text = review.reviewerName
            reviewText.text = review.reviewText
        
            
            if let reviewImageURL = URL(string: review.reviewerPhoto) {
                reviewImage.sd_setImage(with: reviewImageURL) {
                    [weak self] image,
                    error,
                    cacheType,
                    url in
                    guard let self = self else { return }
                    if let _ = image {
                        self.verticalStack.addArrangedSubview(self.reviewImage)
                        
                        self.reviewImage.snp.makeConstraints { make in
                            make.top.equalTo(self.reviewText.snp.bottom).offset(10)
                            make.leading.trailing.equalToSuperview()
                            make.height.equalTo(110)
                        }
                    } else {
                        print("Failed to load image: \(error?.localizedDescription ?? "unknown error")")
                    }
                }
            } else {
                print("Invalid image URL")
            }
        }
}

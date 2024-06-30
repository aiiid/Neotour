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
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()

    private lazy var circleIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "circle.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = Constants.Colors.primaryColor
        image.clipsToBounds = true
        image.alpha = 0 // Initially hidden by setting alpha to 0
        return image
    }()

    private lazy var placeholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
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
        verticalStackView.addArrangedSubview(categoryTitle)
        verticalStackView.addArrangedSubview(placeholderView)
        placeholderView.addSubview(circleIcon)
        
        addSubview(verticalStackView)
        
        placeholderView.snp.makeConstraints { make in
            make.width.height.equalTo(10)
        }
        
        circleIcon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(tour: TourModel, isSelected: Bool) {
        categoryTitle.text = tour.title
        setCircleVisibility(isSelected)
    }

    private func setCircleVisibility(_ isVisible: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.circleIcon.alpha = isVisible ? 1 : 0
        }
    }
}

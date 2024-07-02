//
//  MainView.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import UIKit
import SnapKit

enum Section: String, CaseIterable {
  case travelCategories = "Travel Categories"
  case discoverPlaces = "Discover Places"
  case recommendedPlaces = "Recommended"
}

class MainView: UIView {
    var travelCollectionView: UICollectionView!
    var loadingIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        travelCollectionView = configureCollectionView()
        loadingIndicator = configureLoadingIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MainView {
    private func configureLoadingIndicator() -> UIActivityIndicatorView {
            let indicator = UIActivityIndicatorView(style: .large)
            addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            return indicator
        }
    
    func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(
            frame: bounds,
            collectionViewLayout: generateLayout()
        )
        addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(
            TravelCategoryCell.self,
            forCellWithReuseIdentifier: TravelCategoryCell.reuseIdentifier
        )
        collectionView.register(
            PlaceholderCell.self,
            forCellWithReuseIdentifier: PlaceholderCell.reuseIdentifier
        )
        collectionView.register(
            PlaceCell.self,
            forCellWithReuseIdentifier: PlaceCell.reuseIdentifier
        )
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: HeaderView.sectionHeaderElementKind,
            withReuseIdentifier: HeaderView.reuseIdentifier)
        
        return collectionView
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [self] sectionIndex, environment in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            
            switch sectionLayoutKind {
            case .travelCategories:
                return travelCategorySection()
            case .discoverPlaces:
                return discoverSection()
            case .recommendedPlaces:
                return recommendedSection()
            }
        }
    }
    
    private func travelCategorySection() -> NSCollectionLayoutSection {
        let padding = Constants.UISettings.padding
        let interGroupSpacing = Constants.UISettings.interGroupSpacing
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.18),
            heightDimension: .fractionalHeight(0.05)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 5, trailing: padding)
        section.interGroupSpacing = interGroupSpacing
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func discoverSection() -> NSCollectionLayoutSection {
        let padding = Constants.UISettings.padding
        let interGroupSpacing = Constants.UISettings.interGroupSpacing
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(335),
            heightDimension: .absolute(254)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: padding, trailing: padding)
        section.interGroupSpacing = interGroupSpacing
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func recommendedSection() -> NSCollectionLayoutSection {
        let padding = Constants.UISettings.padding
        let interGroupSpacing = Constants.UISettings.interGroupSpacing
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(185)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: HeaderView.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        section.interGroupSpacing = interGroupSpacing
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
}

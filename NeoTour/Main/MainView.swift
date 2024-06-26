//
//  MainView.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import UIKit
import SnapKit


class MainView: UIView {
    var travelCollectionView: UICollectionView! = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MainView {
    func configureCollectionView() {
       let collectionView = UICollectionView(
        frame: bounds,
                collectionViewLayout: generateLayout()
            )
        addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(
                TravelCategoryCell.self,
                forCellWithReuseIdentifier: TravelCategoryCell.cellIdentifier
            )
        collectionView.register(
                DiscoverPlaceCell.self,
                forCellWithReuseIdentifier: DiscoverPlaceCell.cellIdentifier
            )
        travelCollectionView = collectionView
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            
            switch sectionLayoutKind {
            case .travelCategories:
                return AppLayouts.shared.travelCategorySection()
            case .discoverPlaces:
                return AppLayouts.shared.discoverPlacesSection()
            case .recommendedPlaces:
                return AppLayouts.shared.dayForecastSection()
            }
        }
    }
}

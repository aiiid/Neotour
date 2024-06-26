//
//  MainViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import UIKit

class MainViewController: UIViewController {
    private let contentView = MainView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        setupNavBar()
        setupDataSource()
      
    }
    
    func setupNavBar() {
        title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupDataSource() {
        contentView.travelCollectionView.delegate = self
        contentView.travelCollectionView.dataSource = self
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionLayoutKind = Section.allCases[indexPath.section]
        
        switch sectionLayoutKind {
        case .travelCategories:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TravelCategoryCell.cellIdentifier,
                for: indexPath
            ) as? TravelCategoryCell else {
                return UICollectionViewCell()
            }
            
            cell.set(title: "Test")
            return cell
        case .discoverPlaces:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DiscoverPlaceCell.cellIdentifier,
                for: indexPath
            ) as? DiscoverPlaceCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: UIImage(named: "onboardingImage")!, title: "Test title lorem")
            return cell
        case .recommendedPlaces:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TravelCategoryCell.cellIdentifier,
                for: indexPath
            ) as? TravelCategoryCell else {
                return UICollectionViewCell()
            }
            
            cell.set(title: "Test")
            return cell
        }
        
        
    }
}

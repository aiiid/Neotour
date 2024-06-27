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
        setupNavBar()
        setupDataSource()
    }
    
    func setupNavBar() {
        title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupDataSource() {
        contentView.travelCollectionView.delegate = self
        contentView.travelCollectionView.dataSource = self
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionLayoutKind = Section.allCases[indexPath.section]
        
        switch sectionLayoutKind {
            case .travelCategories:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TravelCategoryCell.reuseIdentifier,
                    for: indexPath
                ) as? TravelCategoryCell else {
                    return UICollectionViewCell()
                }
            
                cell.set(title: "Test")
            
                return cell
            case .discoverPlaces:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PlaceCell.reuseIdentifier,
                    for: indexPath
                ) as? PlaceCell else {
                    return UICollectionViewCell()
                }
            
                cell.configure(
                    with: UIImage(named: "onboardingImage")!,
                    title: "Test title lorem"
                )
                return cell
            case .recommendedPlaces:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PlaceCell.reuseIdentifier,
                    for: indexPath
                ) as? PlaceCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(
                    with: UIImage(
                        named: "onboardingImage"
                    )!,
                    title: "Test title lorem"
                )
                return cell
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == AppLayouts.sectionHeaderElementKind,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
            fatalError("Cannot create header view")
        }
        header.configure(with: Section.allCases[indexPath.section].rawValue)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionLayoutKind = Section.allCases[indexPath.section]
        switch sectionLayoutKind {
        case .travelCategories:
            print("Reload data")
            // Perform any other actions if needed for TravelCategoryCell
        case .discoverPlaces, .recommendedPlaces:
            let detailVC = DetailViewController()
            // Pass any data to detailVC if needed
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

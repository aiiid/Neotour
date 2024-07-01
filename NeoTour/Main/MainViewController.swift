//
//  MainViewController.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import UIKit

class MainViewController: UIViewController {
    private let contentView = MainView()
    private let viewModel = MainViewModel()
    private var selectedCategoryIndex: IndexPath?
    
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
        selectedCategoryIndex = IndexPath(item: 0, section: 0)
        contentView.travelCollectionView.reloadData()
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section.allCases[section] {
        case .travelCategories:
            return viewModel.tourArray.count
        case .discoverPlaces:
            return viewModel.discoveryArray.count
        case .recommendedPlaces:
            return viewModel.recommendationArray.count
        }
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
            
            let category = viewModel.categories[indexPath.row]
            let isSelected = indexPath == selectedCategoryIndex
            
            cell.set(category: category.rawValue, isSelected: isSelected)
            return cell
            
        case .discoverPlaces:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PlaceCell.reuseIdentifier,
                for: indexPath
            ) as? PlaceCell else {
                return UICollectionViewCell()
            }
            
            let tour = viewModel.discoveryArray[indexPath.row]
            cell.configure(with: tour)
            
            return cell
            
        case .recommendedPlaces:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PlaceCell.reuseIdentifier,
                for: indexPath
            ) as? PlaceCell else {
                return UICollectionViewCell()
            }
            
            let place = viewModel.recommendationArray[indexPath.row]
            cell.configure(with: place)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == HeaderView.sectionHeaderElementKind,
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
            if let previousSelectedIndex = selectedCategoryIndex {
                selectedCategoryIndex = indexPath
                collectionView.reloadItems(at: [previousSelectedIndex, indexPath])
            } else {
                selectedCategoryIndex = indexPath
                collectionView.reloadItems(at: [indexPath])
            }
        case .discoverPlaces, .recommendedPlaces:
            let detailVC = DetailViewController()
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

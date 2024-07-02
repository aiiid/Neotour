//
//  PlaceholderCell.swift
//  NeoTour
//
//  Created by Ai Hawok on 02/07/2024.
//

import UIKit
import SnapKit

class PlaceholderCell: UICollectionViewCell {
    static let reuseIdentifier = "PlaceholderCell"
    
    private let placeholderView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(placeholderView)
        
        placeholderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

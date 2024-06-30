//
//  Constants.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import UIKit

struct Constants {
    struct UISettings{
        static let padding: CGFloat = 16
        static let interGroupSpacing: CGFloat = 15
    }
    
    struct Colors {
        static let primaryColor = UIColor(hex: "#6A62B7")
        static let secondaryColor = UIColor(hex: "#6A62B7")
        static let backgroundColor = UIColor.systemBackground
        static let textColor = UIColor.label
    }
    
    struct Fonts {
        static let titleFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let bodyFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
}

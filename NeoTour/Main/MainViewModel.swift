//
//  MainViewModel.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import Foundation

struct TourModel {
    let id = UUID()
    let title: String
}

struct PlaceModel {
    let id = UUID()
    let title: String
    let image: String
}

class MainViewModel {
    var tourArray = [
        TourModel(title: "Popular"),
        TourModel(title: "Featured"),
        TourModel(title: "Europe"),
        TourModel(title: "Asia"),
        TourModel(title: "Most visited")
    ]
    var discoveryArray = [
        PlaceModel(title: "Fuji 1", image: "dummy1"),
        PlaceModel(title: "Fuji 2", image: "dummy2"),
        PlaceModel(title: "Fuji 3", image: "dummy3")
    ]
    
    var recommendationArray = [
        PlaceModel(title: "Random Place", image: "onboardingImage"),
        PlaceModel(title: "Not so random Fuji", image: "dummy2")
    ]
}

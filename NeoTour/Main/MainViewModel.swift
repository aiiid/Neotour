//
//  MainViewModel.swift
//  NeoTour
//
//  Created by Ai Hawok on 25/06/2024.
//

import Foundation

enum TourCategory: String, CaseIterable {
    case popular
    case featured
    // Add other categories as needed
}

struct TourModel: Codable {
    let id: String
    let reviews: [Review]
    let name: String
    let location: String
    let description: String
    let thumbnail: String
    let bookingLimit: Int
    let createdDate: String
    let updatedDate: String
    let isOnPromotion: Bool
    let region: String
    let category: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case reviews
        case name
        case location
        case description
        case thumbnail
        case bookingLimit = "booking_limit"
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case isOnPromotion = "is_on_promotion"
        case region
        case category
    }
}

struct PlaceModel {
    let id = UUID()
    let title: String
    let image: String
}

class MainViewModel {
    var categories: [TourCategory] = TourCategory.allCases
    var tourArray: [TourModel] = []
    var discoveryArray : [TourModel] = []
    var recommendationArray: [TourModel] = []
    
    func fetchTours(by category: TourCategory, completion: @escaping (Result<[TourModel], Error>) -> Void) {
            NetworkManager.shared.fetchTours(by: category) { result in
                switch result {
                case .success(let tours):
                    self.tourArray = tours
                    completion(.success(tours))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}

enum Region: String, CaseIterable, Codable {
    case europe = "Europe"
    case asia = "Asia"
    case northAmerica = "North America"
    case southAmerica = "South America"
    case africa = "Africa"
    case australia = "Australia"
    case antarctica = "Antarctica"

    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "europe":
            self = .europe
        case "asia":
            self = .asia
        case "north_america":
            self = .northAmerica
        case "south_america":
            self = .southAmerica
        case "africa":
            self = .africa
        case "australia":
            self = .australia
        case "antarctica":
            self = .antarctica
        default:
            return nil
        }
    }

    var stringValue: String {
        switch self {
        case .europe:
            return "europe"
        case .asia:
            return "asia"
        case .northAmerica:
            return "north_america"
        case .southAmerica:
            return "south_america"
        case .africa:
            return "africa"
        case .australia:
            return "australia"
        case .antarctica:
            return "antarctica"
        }
    }
}

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

struct Review: Codable {
    let tour: String
    let reviewerName: String
    let reviewerPhoto: String
    let reviewText: String
    
    enum CodingKeys: String, CodingKey {
        case tour
        case reviewerName = "reviewer_name"
        case reviewerPhoto = "reviewer_photo"
        case reviewText = "review_text"
    }
}

struct PlaceModel {
    let id = UUID()
    let title: String
    let image: String
}

class MainViewModel {
    var tourArray: [TourModel] = []
    var categories: [TourCategory] = TourCategory.allCases
    var isLoading: Bool = true
    
    func fetchTours(by category: TourCategory, completion: @escaping (Result<[TourModel], Error>) -> Void) {
        let urlString = "https://muha-backender.org.kg/category-tour/\(category.rawValue)/"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        NetworkManager.shared.request(url: url, method: .GET, responseType: [TourModel].self) { result in
            DispatchQueue.main.async {
                self.isLoading = false
            }
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

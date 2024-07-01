//
//  BookingViewModel.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//

import Combine
import Foundation
import Combine
import Foundation

class BookingViewModel {
    @Published var phoneNumber: String = ""
    @Published var comment: String = ""
    @Published var numberOfPeople: Int = 1

    var isFormValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($phoneNumber, $comment, $numberOfPeople)
            .map { phoneNumber, comment, numberOfPeople in
                return !phoneNumber.isEmpty && numberOfPeople > 0
            }
            .eraseToAnyPublisher()
    }
    
    func createBooking(tourId: String, completion: @escaping (Result<BookingResponse, Error>) -> Void) {
        let bookingRequest = BookingRequest(
            phoneNumber: phoneNumber,
            numberOfPeople: numberOfPeople,
            tour: tourId
        )
        
        guard let url = URL(string: "https://muha-backender.org.kg/create-booking/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        NetworkManager.shared.request(url: url, method: .POST, body: bookingRequest, responseType: BookingResponse.self) { result in
            completion(result)
        }
    }
}

struct BookingRequest: Codable {
    let phoneNumber: String
    let numberOfPeople: Int
    let tour: String
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case numberOfPeople = "number_of_people"
        case tour
    }
}

struct BookingResponse: Codable {
    let phoneNumber: [String]?
    let numberOfPeople: [String]?
    let tour: [String]?
}

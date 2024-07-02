//
//  BookingViewModel.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//

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
            
            NetworkManager.shared.postRequest(url: url, body: bookingRequest, responseType: BookingResponse.self) { result in
                switch result {
                case .success(let response):
                    print("Booking successful: \(response)")
                    completion(.success(response))
                case .failure(let error):
                    print("completion failed")
                    print("Error: \(error)")
                    completion(.failure(error))
                }
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

struct BookingResponse: Decodable {
    let id: Int?
    let phoneNumber: String
    let comment: String?
    let numberOfPeople: Int
    let tour: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case phoneNumber = "phone_number"
        case comment
        case numberOfPeople = "number_of_people"
        case tour
    }
}

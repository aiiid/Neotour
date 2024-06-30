//
//  BookingViewModel.swift
//  NeoTour
//
//  Created by Ai Hawok on 30/06/2024.
//

import Combine

class BookingViewModel {
    @Published var phoneNumber: String = ""
    @Published var comment: String = ""
    
    var isFormValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($phoneNumber, $comment)
            .map { phoneNumber, comment in
                return !phoneNumber.isEmpty && !comment.isEmpty
            }
            .eraseToAnyPublisher()
    }
}

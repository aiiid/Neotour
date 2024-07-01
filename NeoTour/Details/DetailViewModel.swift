//
//  DetailModel.swift
//  NeoTour
//
//  Created by Ai Hawok on 26/06/2024.
//

import UIKit

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

struct User {
    var username: String
    var userImage: String
}

struct Location {
    var mainImage: String
    var title: String
    var description: String
    var location: String
}

class DetailViewModel {
    var reviews = [
        Review(user: User(username: "User1", userImage: "person.circle"),
               textReview: "Great place!"),
        Review(user: User(username: "User2", userImage: "person.circle"),
               textReview: "Amazing experience. Lorem ipsum great cuisine rlloo lalalosgd odsosl oo kkk lals fasoifhsfn nnummi lasinfoo lasnfoief klnasf o",
               images: ["dummy1.jpg", "dummy2.jpg", "dummy3.jpg"])
    ]
    
    var location = Location(
        mainImage: "onboardingImage.png",
        title: "Mount Fuji",
        description: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Dignissim eget amet viverra eget fames rhoncus.
        Eget enim venenatis enim porta egestas malesuada et.
        Consequat mauris lacus euismod montes.
        """, 
        location: "Fuji Kawaguchiko, Japan"
    )
}

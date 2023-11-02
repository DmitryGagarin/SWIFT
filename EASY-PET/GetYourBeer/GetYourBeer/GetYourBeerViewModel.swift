//
//  GetYourBeerViewModel.swift
//  GetYourBeer
//
//  Created by Dmitry Fatsievich on 02.11.2023.
//

import Foundation

struct GetYourBeerViewModel: Codable, Identifiable {
    var id: Int
    var name: String
    var price: String
    var image: String
    var rating: Rating
}

struct Rating: Codable {
    var average: Double
    var reviews: Int
}

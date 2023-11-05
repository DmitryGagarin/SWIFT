//
//  Info.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//
//  Model of the Info document of the Quiz collection

import SwiftUI

struct Info: Codable {
    var title: String
    var peopleAttended: Int
    var rules: [String]
    var quizNumber: Int
    
    enum CodingKeys: CodingKey {
        case title
        case peopleAttended
        case rules
        case quizNumber
    }
}

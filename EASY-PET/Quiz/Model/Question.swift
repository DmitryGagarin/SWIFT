//
//  Question.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//

import SwiftUI

struct Question: Identifiable, Codable {
    var id: UUID = .init()
    var question: String
    var option: [String]
    var answer: String
    
    var tappedAnswer: String = ""
    
    enum CodingKeys: CodingKey {
        case question
        case option
        case answer
    }
}

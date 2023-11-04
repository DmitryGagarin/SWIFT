//
//  Question.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//
//  Model of the Quiz collection inside Info document

import SwiftUI

struct Question: Identifiable, Codable {
    var id: UUID = .init()
    var question: String
    var option: [String]
    var answer: String
    
    var tappedAnswer: String = "" // controls user's taps
    
    enum CodingKeys: CodingKey {
        case question
        case option
        case answer
    }
}

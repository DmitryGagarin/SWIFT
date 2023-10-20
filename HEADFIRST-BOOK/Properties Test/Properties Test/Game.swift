//
//  Game.swift
//  Properties Test
//
//  Created by Dmitry Fatsievich on 20.10.2023.
//

import Foundation

class GameScore: ObservableObject{
    @Published var numericalScore = 0
    @Published var piecesCaptures = 0
    @Published var score = 0
    @Published var pieces = 0
}


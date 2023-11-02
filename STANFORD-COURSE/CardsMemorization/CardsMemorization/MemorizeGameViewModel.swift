//
//  MemorizeGameViewModel.swift
//  CardsMemorization
//
//  Created by Dmitry Fatsievich on 22.10.2023.
//

import SwiftUI

class MemorizeGameViewModel: ObservableObject {
    typealias Card = MemorizeGameModel<String>.Card
    
    private static let emojis = ["👻","😈","🕷️","🎃","🧙","😬","🙀","💀","🕸️","👹","😱","😰"]
    
    private static func createMemoreGame() -> MemorizeGameModel<String>{
        return MemorizeGameModel(numberOfPairsOfCards: 12) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "??"
            }
        }
    }
    
    @Published private var model = createMemoreGame()
    
    var cards: Array<Card>{
        return model.cards
    }
    
    var score: Int{
        model.score
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: Card){
        model.choose(card)
    }
}

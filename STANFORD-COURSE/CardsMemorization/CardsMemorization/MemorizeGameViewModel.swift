//
//  MemorizeGameViewModel.swift
//  CardsMemorization
//
//  Created by Dmitry Fatsievich on 22.10.2023.
//

import SwiftUI

class MemorizeGameViewModel: ObservableObject {
    private static let emojis = ["👻","😈","🕷️","🎃","🧙","😬","🙀","💀","🕸️","👹","😱","😰"]
    
    private static func createMemoreGame() -> MemorizeGameModel<String>{
        return MemorizeGameModel(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "??"
            }
        }
    }
        
    @Published private var model = createMemoreGame()
    
    var cards: Array<MemorizeGameModel<String>.Card>{
        return model.cards
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: MemorizeGameModel<String>.Card){
        model.choose(card)
    }
}

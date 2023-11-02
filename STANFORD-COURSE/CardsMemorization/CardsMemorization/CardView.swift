//
//  CardView.swift
//  CardsMemorization
//
//  Created by Dmitry Fatsievich on 01.11.2023.
//

import SwiftUI

struct CardView: View {
    
    typealias Card = MemorizeGameModel<String>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View{
        TimelineView(.animation){ timeline in
            if card.isFaceUp || !card.isMatched {
                PieShape(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(0.4)
                    .overlay(cardContent.padding(5))
                    .padding(5)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContent: some View{
        Text(card.content)
            .font(.system(size: 200))
            .minimumScaleFactor(0.01)
            .aspectRatio(1, contentMode: .fit)
            .multilineTextAlignment(.center)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 2), value: card.isMatched)
    }
}

extension Animation{
    static func spin(duration: TimeInterval) -> Animation{
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}


struct CardView_Previews: PreviewProvider{
    typealias Card = CardView.Card
    
    static var previews: some View{
        VStack{
            HStack{
                CardView(Card(isFaceUp: true, content: "x", id: "test1"))
                    .aspectRatio(4/3, contentMode: .fit)
                CardView(Card(content: "x", id: "test1"))
            }
            HStack{
                CardView(Card(isFaceUp: true, isMatched: true, content: "x", id: "test1"))
                CardView(Card(isMatched: true, content: "x", id: "test1"))
            }
        }
        .padding()
        .foregroundColor(.green)
    }
}

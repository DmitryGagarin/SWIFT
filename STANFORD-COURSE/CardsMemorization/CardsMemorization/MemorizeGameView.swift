//
//  MemorizeGameView.swift
//  CardsMemorization
//
//  Created by Dmitry Fatsievich on 22.10.2023.
//

import SwiftUI

struct MemorizeGameView: View {
    
    @ObservedObject var viewModel: MemorizeGameViewModel
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    typealias Card = MemorizeGameModel<String>.Card
    
    var body: some View {
        VStack{
            cards
            HStack{
                score
                Spacer()
                deck
                    .foregroundColor(.orange)
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .onAppear{viewModel.shuffle()}
        .padding()
    }
    
    private var score: some View{
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View{
        Button("Shuffle"){
            withAnimation(.easeInOut){
                viewModel.shuffle()
            }
        }
    }
    
    private var cards: some View{
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card){
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture{
                        choose(card)
                    }
            }
        }
        
        .foregroundColor(Color.orange)
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card]{
        viewModel.cards.filter {!isDealt($0)}
    }
    
    @Namespace private var dealingNameSpace
    
    private var deck: some View{
        ZStack{
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
            .frame(width: deckWidth, height: deckWidth / aspectRatio)
            .onTapGesture {
                deal()
            }
        }
    }
    
    private let dealInterval: TimeInterval = 0.25
    private let deckWidth: CGFloat = 50
    
    private func deal(){
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration: 1).delay(delay)){
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    private func choose (_ card: Card){
        withAnimation(.easeInOut(duration:1)){
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int{
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}

#Preview {
    MemorizeGameView(viewModel: MemorizeGameViewModel())
}

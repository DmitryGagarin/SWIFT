//
//  MemorizeGameView.swift
//  CardsMemorization
//
//  Created by Dmitry Fatsievich on 22.10.2023.
//

import SwiftUI

struct MemorizeGameView: View {
    
    @ObservedObject var viewModel: MemorizeGameViewModel
    
    var body: some View {
        VStack{
            ScrollView{
                cards
                    .animation(.default , value: viewModel.cards)
            }
            Button("Shuffle"){
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture(perform: {
                        viewModel.choose(card)
                    })
            }
        }.foregroundColor(Color.orange)
    }
}


struct CardView: View {
    
    let card: MemorizeGameModel<String>.Card
    
    init(_ card: MemorizeGameModel<String>.Card) {
        self.card = card
    }
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    MemorizeGameView(viewModel: MemorizeGameViewModel())
}

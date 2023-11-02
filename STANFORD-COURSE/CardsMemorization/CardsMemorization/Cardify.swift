//
//  Cardify.swift
//  CardsMemorization
//
//  Created by Dmitry Fatsievich on 01.11.2023.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable{
    
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    var rotation: Double
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    var isFaceUp: Bool {
        rotation < 90
    }
    
    func body(content: Content) -> some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.strokeBorder(lineWidth: 3)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }
}

extension View{
    func cardify(isFaceUp: Bool) -> some View{
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}



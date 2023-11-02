//
//  FlyingNumber.swift
//  CardsMemorization
//
//  Created by Dmitry Fatsievich on 02.11.2023.
//

import SwiftUI

struct FlyingNumber: View {
    
    let number: Int
    @State private var offset: CGFloat = -50
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number < 0 ? .red : .green)
                .shadow(color: .black, radius: 3, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .onAppear{
                    withAnimation(.easeIn(duration: 2)){
                        offset = number < 0 ? 500 : -UIScreen.main.bounds.size.height
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyingNumber(number:5)
}

//
//  PizzaView.swift
//  Pizza Preview
//
//  Created by Dmitry Fatsievich on 20.10.2023.
//

import SwiftUI

struct PizzaView: View {
    var body: some View {
        VStack (alignment: .leading){
            Text("Welcome to")
                .font(.system(size: 50)).fontWeight(.heavy)
                .foregroundColor(.primary)
            Text("Swift pizza")
                .font(.system(size: 50)).fontWeight(.heavy)
                .foregroundColor(Color(UIColor.systemBlue).opacity(0.8))
                .padding(.bottom, 120)
            
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .top, spacing: 20){
                    Image(systemName: "bag").resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(UIColor.systemBlue).opacity(0.8))
                    VStack(alignment: .leading, spacing: 4){
                        Text("Order Everything")
                            .font(.headline).bold()
                        Text("Our whole menu is available in the app.")
                            .font(.subheadline)
                    }
                }
                HStack(alignment: .top, spacing: 20){
                    Image(systemName: "giftcard").resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(UIColor.systemBlue).opacity(0.8))
                    VStack(alignment: .leading, spacing: 4){
                        Text("Buy Gift Cards")
                            .font(.headline).bold()
                        Text("Buy a gift card, check card balance and more.")
                            .font(.subheadline)
                    }
                }
                HStack(alignment: .top, spacing: 20){
                    Image(systemName: "fork.knife").resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(UIColor.systemBlue).opacity(0.8))
                    VStack(alignment: .leading, spacing: 4){
                        Text("Custom Pizzas")
                            .font(.headline).bold()
                        Text("Pick and choose ingredients to make your dream pizza.")
                            .font(.subheadline)
                    }
                }
                Spacer()
                Button(action: {}) {
                    Text("Welcome")
                        .foregroundColor(.white)
                        .bold()
                } .frame(width: 350, height: 60)
                    .background(Color(UIColor.systemBlue)
                        .opacity(0.8))
                    .cornerRadius(24)
            }.padding(.all, 10)
        }
    }
}

#Preview {
    PizzaView()
}

//
//  ContentView.swift
//  Properties Test
//
//  Created by Dmitry Fatsievich on 20.10.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameScore = GameScore()
    var body: some View {
        NavigationView{
            VStack {
                Text("Your score is \(gameScore.numericalScore)")
                Text("You have collected \(gameScore.piecesCaptures) pieces")
                
                Button("Bigger me"){
                    gameScore.numericalScore += 1
                }
                .font(.system(size: 26))
                .foregroundColor(.black)
                .buttonStyle(.bordered)
                .tint(.green)
                Button("More pieces"){
                    gameScore.piecesCaptures += 1
                    
                }
                .font(.system(size: 26))
                .foregroundColor(.black)
                .buttonStyle(.bordered)
                .tint(.green)
                NavigationLink(destination: ScoreView()){
                    Text("View Scores...")
                        .padding()
                }
            }
        } .environmentObject(gameScore)
    }
}

struct ScoreView: View{
    @EnvironmentObject var gameScore: GameScore
    var body: some View{
        VStack{
            Text("The score is \(gameScore.numericalScore)")
            Text("The piece count is \(gameScore.piecesCaptures)")
            Spacer()
        }
    }
}


#Preview {
    ContentView()
}

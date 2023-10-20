//
//  ContentView.swift
//  Executive Timer
//
//  Created by Dmitry Fatsievich on 20.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    let defaultTime: CGFloat = 5
    @State private var timerRunning = false
    @State private var countdownTime: CGFloat
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let strokeStyle = StrokeStyle(lineWidth: 15, lineCap: .round)
    
    init(){
        countdownTime = defaultTime
    }
    
    var body: some View {
        let countdownColor: Color = {
            switch (countdownTime){
            case 6...: return Color.green
            case 3...: return Color.yellow
            default: return Color.red
            }
        }()
        
        let buttonIcon = timerRunning ? "pause.rectangle.fill" : "play.rectangle.fill"
        VStack{
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: strokeStyle)
                Circle()
                    .trim(from: 0, to: 1 - ((defaultTime - countdownTime) / defaultTime))
                    .stroke(countdownColor, style: strokeStyle)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut)
                
                HStack (spacing: 25){
                    Label("", systemImage: buttonIcon)
                        .foregroundColor(.black) .font(.title)
                        .onTapGesture(perform: {
                            timerRunning.toggle()
                        })
                    Text("\(Int(countdownTime))")
                        .font(.largeTitle)
                    Label("", systemImage: "gobackward")
                        .foregroundColor(.red)
                        .font(.title)
                        .onTapGesture(perform: {
                            timerRunning = false
                            countdownTime = defaultTime
                        })
                }
            } .frame(width: 300, height: 300)
                .onReceive(timer, perform: { _ in
                    guard timerRunning else {return}
                    if countdownTime > 0{
                        countdownTime -= 1
                    } else {
                        timerRunning = false
                        countdownTime = defaultTime
                    }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}


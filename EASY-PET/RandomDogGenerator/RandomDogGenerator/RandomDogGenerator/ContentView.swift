//
//  ContentView.swift
//  RandomDogGenerator
//
//  Created by Dmitry Fatsievich on 21.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var photosNames: [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
    @State private var prev: String = ""
    @State private var randomPhoto: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    let temp = randomPhoto
                    randomPhoto = prev
                    prev = temp
                }, label: {
                    Image(systemName: "arrowshape.backward")
                    Text("Previous")
                }).padding()
                    .buttonStyle(.bordered)
                
                Button(action: {
                    let newRandomPhoto = self.photosNames.randomElement() ?? self.photosNames[0]
                    prev = randomPhoto
                    randomPhoto = newRandomPhoto
                }, label: {
                    Text("Generate Photo")
                }).padding()
                    .buttonStyle(.bordered)
                
            }
            Spacer()
            
            if photosNames.isEmpty{
                Text("That's all")
            }
            
            if !randomPhoto.isEmpty{
                Image(randomPhoto)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 400, maxHeight: 800)
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  RandomDogGenerator
//
//  Created by Dmitry Fatsievich on 21.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    let photos = ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
    @State private var randomPhoto: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.randomPhoto = self.photos[0] // get previous photo
                }, label: {
                    Image(systemName: "arrowshape.backward")
                    Text("Previous")
                })
                
                Button(action: {
                    self.randomPhoto = self.photos.randomElement() ?? self.photos[1]
                }, label: {
                    Text("Generate Photo")
                }).padding()
                
                Button(action: {
                    self.randomPhoto = self.photos[2] // get next photo
                }, label: {
                    Text("Next")
                    Image(systemName: "arrowshape.forward")
                })
            }
            
            if !randomPhoto.isEmpty{
                Image(randomPhoto)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    //.frame(alignment: .center)
            }
            Spacer()
        }.edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}

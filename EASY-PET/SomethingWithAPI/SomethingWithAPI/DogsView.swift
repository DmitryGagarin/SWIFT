//
//  DogsView.swift
//  SomethingWithAPI
//
//  Created by Dmitry Fatsievich on 21.10.2023.
//

import SwiftUI

struct DogsView: View {
    
    @State private var imageURL: URL?
    @State private var isLoading = false
    @State private var isError = false
    
    var body: some View {
        NavigationView {
            VStack{
                if let imageURL = imageURL {
                    AsyncImage(url: imageURL){ image in image.resizable()
                    } placeholder: {ProgressView()}
                        .aspectRatio(contentMode: .fit)
                        .frame(alignment: .center)
                }
            }
            .navigationTitle("Take your dog ❤️")
        }
        .edgesIgnoringSafeArea(.all)
        .padding()
        .onTapGesture (count:2){
            fetchRandomDogImage()
        }
        .onAppear {
            fetchRandomDogImage()
        }
    }
    
    
    func fetchRandomDogImage() {
        if let url = URL(string: "https://dog.ceo/api/breeds/image/random") {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if let data = data,
                   let response = try? JSONDecoder().decode(DogImageResponse.self, from: data),
                   let imageURL = URL(string: response.message) {
                    DispatchQueue.main.async {
                        self.imageURL = imageURL
                        isLoading = false
                    }
                } else {
                    isLoading = false
                    isError = true
                }
            }.resume()
        }
    }
}

struct DogImageResponse: Codable {
    let message: String
    let status: String
}

#Preview {
    DogsView()
}

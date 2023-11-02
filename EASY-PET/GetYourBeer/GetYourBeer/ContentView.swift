//
//  ContentView.swift
//  GetYourBeer
//
//  Created by Dmitry Fatsievich on 02.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var beers: [Beer] = []
    @State private var isNavigationBarHidden: Bool = false
    var body: some View {
        NavigationView {
            List(beers) { beer in
                VStack {
                    AsyncImage(url: URL(string: beer.image)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 200)
                        } else if phase.error != nil {
                            Image("beer")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            ProgressView()
                        }
                        
                        HStack {
                            NavigationLink(destination: ProductView(beer: beer)) {
                                Text("\(beer.name)")
                            }
                            Spacer()
                            Text(beer.price)
                        }.padding()
                    }
                }
            }
            .navigationBarHidden(self.isNavigationBarHidden)
            .navigationTitle("Choose your fighter")
        }
        .onAppear { BeerShow().getBeer { fetchedBeer in self.beers = fetchedBeer } }
    }
}

struct Beer: Codable, Identifiable {
    var id: Int
    var name: String
    var price: String
    var image: String
    var rating: Rating
}

struct Rating: Codable {
    var average: Double
    var reviews: Int
}

struct ProductView: View {
    let beer: Beer
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: beer.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 200)
                } else if phase.error != nil {
                    Image("beer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    ProgressView()
                }
            }
                Spacer()
                Text("Name: '\(beer.name)' ")
                Text("Price: \(beer.price) ")
                Text("Number of reviews: \(beer.rating.reviews)")
                Text("Average rating: \(beer.rating.average)")
        }
        .padding()
        .font(.title)
        .navigationTitle(beer.name)
    }
}

class BeerShow {
    func getBeer(completion: @escaping ([Beer]) -> ()) {
        guard let url = URL(string: "https://api.sampleapis.com/beers/ale") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let beers = try JSONDecoder().decode([Beer].self, from: data)
                    DispatchQueue.main.async {
                        completion(beers)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        .resume()
    }
}

#Preview {
    ContentView()
}



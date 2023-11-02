//
//  ContentView.swift
//  MovieList
//
//  Created by Dmitry Fatsievich on 03.11.2023.
//

import SwiftUI

struct MovieListView: View {
    @State private var movies: [Movie] = []
    @State private var selectedGenre: MovieGenre = .animation
    var body: some View {
        NavigationView{
            VStack {
                Picker("Movie Genre", selection: $selectedGenre) {
                    ForEach(MovieGenre.allCases) { genre in
                        Text(genre.rawValue)
                            .tag(genre)
                            .font(.system(size: 20))
                    }
                }.pickerStyle(.menu)
                    .onChange(of: selectedGenre) { newGenre, _ in
                        ShowMovie().getMovie(for: newGenre) { fetchedMovies in
                            self.movies = fetchedMovies }
                    }
                List(movies) { movie in
                    VStack (alignment: .center) {
                        AsyncImage(url: URL(string: movie.posterURL)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } else {
                                ProgressView()
                            }
                            Text("\(movie.title)")
                                .font(.title)
                                .fontDesign(.serif)
                        }
                    }
                }
            }
            .navigationBarTitle(Text(selectedGenre.rawValue))
            .padding()
        }
        .onAppear{
            ShowMovie().getMovie(for: selectedGenre) { fethedMovie in self.movies = fethedMovie }
        }
    }
}

enum MovieGenre: String, CaseIterable, Identifiable {
    case animation = "Animation"
    case classic = "Classic"
    case comedy = "Comedy"
    case drama = "Drama"
    case horror = "Horror"
    case family = "Family"
    case western = "Western"
    case mystery = "Mystery"
    var id: MovieGenre { self }
}

struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var posterURL: String
}

class ShowMovie {
    func getMovie(for genre: MovieGenre,completition: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.sampleapis.com/movies/\(genre.rawValue.lowercased())") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let movies = try JSONDecoder().decode([Movie].self, from: data)
                    DispatchQueue.main.async {
                        completition(movies)
                    }
                } catch {
                    print("Erro encoding JSON \(error)")
                }
            }
        }
        .resume()
    }
}

#Preview {
    MovieListView()
}

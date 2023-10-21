//
//  PostsView.swift
//  SomethingWithAPI
//
//  Created by Dmitry Fatsievich on 21.10.2023.
//

import SwiftUI

struct PostsView: View {
    @State private var posts: [Post] = []
    var body: some View {
        NavigationView {
            List(posts) { post in
                VStack() { // Added alignment for better formatting
                    Text(post.title)
                        .fontWeight(.heavy)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(post.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .onAppear {
                PostApi().getPosts { fetchedPosts in // Renamed 'getPost' to 'getPosts' for consistency
                    self.posts = fetchedPosts
                }
            }
        }
        .navigationBarTitle("Posts")
    }
}


struct Post: Codable, Identifiable {
    var id: Int
    var title: String
    var body: String
}

class PostApi {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        completion(posts)
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
    PostsView()
}

//
//  ContentView.swift
//  SomethingWithAPI
//
//  Created by Dmitry Fatsievich on 21.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            PostsView()
                .padding()
                .tabItem {
                    Label("Posts View", systemImage: "book.fill")
                }
            DogsView()
                .padding()
                .tabItem {
                    Label("Dogs View", systemImage: "pawprint.fill")
                }
        }
    }
}



#Preview {
    ContentView()
}

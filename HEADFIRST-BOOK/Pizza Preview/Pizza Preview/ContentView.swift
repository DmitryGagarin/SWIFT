//
//  ContentView.swift
//  Pizza Preview
//
//  Created by Dmitry Fatsievich on 20.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            PizzaView()
                .padding()
                .tabItem{
                    Label("Pizza View", systemImage: "fork.knife")
                }
            MapView()
                .padding()
                .tabItem {
                    Label("Map View", systemImage: "map")
                }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

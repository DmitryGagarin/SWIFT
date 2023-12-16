//
//  ContentView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            Button {
                ProfileViewViewModel().logOut()
            } label: {
                Text("Log out")
            }
            TabView {
                HomeView()
                    .padding()
                    .tabItem {
                        Label("Quiz", systemImage: "play")
                    }
                ProfileView()
                    .padding()
                    .tabItem {
                        Label("Account", systemImage: "person")
                    }
            }
        } else {
            LoginView()
        }
    }
}


#Preview {
    ContentView()
}

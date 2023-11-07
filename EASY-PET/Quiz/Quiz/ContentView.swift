//
//  ContentView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//
//  TODO: tabview with quiz tab and account tab
//  TODO: ability to upload guizes and questions
//  TODO: add collection of different quizes
//  TODO: add statisctics to the Home View

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TabView {
                HomeView()
                    .padding()
                    .tabItem {
                        Label("Quiz", systemImage: "play")
                    }
                AccountView()
                    .padding()
                    .tabItem {
                        Label("Account", systemImage: "person")
                    }
            }
        } else {
            RegistrationView()
        }
    }
}

#Preview {
    ContentView()
}

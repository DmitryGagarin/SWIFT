//
//  AccountView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 06.11.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    ProgressView()
                    Text("Please wait")
                }
            }
            .navigationTitle("Your account")
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }

    @ViewBuilder
    func profile(user: User) -> some View {
        VStack {
            HStack {
                Text("Name: \(user.name)")
            }
            HStack {
                Text("Surname: \(user.surname)")
            }
            HStack {
                Text("Email: \(user.email)")
            }
        }
    }
}


//
//  RegistrationView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 07.11.2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject var viewModel = RegistrationViewViewModel()
    @State private var isRegistration: Bool = false
    
    var body: some View {
        VStack {
            Form {
                TextField("Your name", text: $viewModel.name)
                    .autocorrectionDisabled()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Your surname", text: $viewModel.surname)
                    .autocorrectionDisabled()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Your email", text: $viewModel.email)
                    .autocorrectionDisabled()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Your password", text: $viewModel.password)
                    .autocorrectionDisabled()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                
                Button("Create account") {
                    print("account created")
                    viewModel.registration()
                }
                
            }
            .scrollContentBackground(.hidden)
            .offset(y: -20)
        }
    }
}

#Preview {
    RegistrationView()
}

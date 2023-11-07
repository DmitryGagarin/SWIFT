//
//  RegistrationView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 07.11.2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject var viewModel = RegistrationViewViewModel()
   
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
                SecureField("Your password", text: $viewModel.password)
                    .autocorrectionDisabled()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    viewModel.registration()
                    print("clicked")
                } label: {
                    Text("Create Account")
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
}

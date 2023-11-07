//
//  LoginView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 07.11.2023.
//

import SwiftUI

struct LoginView: View {

    @StateObject var viewModel = LoginViewViewModel()

    var body: some View {
        NavigationView{
            VStack{
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    TextField("Email address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()

                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    Button("Log in") {
                        print("clicked")
                        viewModel.login()
                    }
                    .padding()
                }
                .scrollContentBackground(.hidden)
                .offset(y: -20)

                // Registration
                VStack{
                    Text("New Around Here?")
                    NavigationLink("Create An Account", destination: RegistrationView())
                }
                .padding(.bottom, 30)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}

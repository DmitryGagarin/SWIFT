//
//  AddQuestionView.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 07.11.2023.
//

import SwiftUI

struct AddQuestionView: View {
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack {
            Form {
                VStack(alignment: .center) {
                    TextField("Your name", text: $name)
                    .padding()
                    
                    TextField("Your surname", text: $surname)
                    .padding()
                    
                    TextField("Your email", text: $email)
                    .padding()
                    
                    SecureField("Your password", text: $password)
                    .padding()
                }
            }
            Button {
                print("Submit")
            } label: {
                Text("Submit")
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        }
    }
}

#Preview {
    AddQuestionView()
}

//
//  LoginViewViewModel.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 07.11.2023.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    func login(){
        guard validation() else{
            return
        }
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validation() -> Bool{
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessage = "Please fill fields correctly"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else{
            errorMessage = "Please fill correct email"
            return false
        }
        return true
    }
    
    init(){}
}

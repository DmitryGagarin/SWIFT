//
//  RegistrationViewViewModel.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 07.11.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class RegistrationViewViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var surname = ""
    @Published var email = ""
    @Published var password = ""
    
    init(){}
    
    func registration(){
//        guard validation() else{
//            return
//        }
        
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String){
        let newUser = User(id: id,
                           name: name,
                           surname: surname,
                           email: email
        )
        let db = Firestore.firestore()
        
        db.collection("Users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
//    private func validation() -> Bool {
//        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
//              !email.trimmingCharacters(in: .whitespaces).isEmpty,
//              !password.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
//        
//        //guard email.contains("@") && email.contains(".") else {return false}
//        
//        return true
//    }
}

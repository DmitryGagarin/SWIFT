//
//  ProfileViewViewModel.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 07.11.2023.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewViewModel: ObservableObject{
    
    @Published var user: User? = nil
    
    func fetchUser(){
        guard let userId = Auth.auth().currentUser?.uid else{
            return
        }
        
        let db = Firestore.firestore()
        
        print("DataBase is okey!!!")
        
        db.collection("users").document(userId).getDocument{ [self]
            snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                self.user = User(id: data["id"] as? String ?? "",
                                 name: data["name"] as? String ?? "",
                                 surname: data["surname"] as? String ?? "",
                                 email: data["email"] as? String ?? ""
                )
            }
        }
    }
    
    func logOut(){
        do{
            try Auth.auth().signOut()
        } catch {
            print("error while loggingOut: \(error)")
        }
    }
    
    
    
    init(){}
    
}

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
    init(){}
    
    func fetchUser(){
        guard let users = Auth.auth().currentUser?.uid else { return }
        
        print(Auth.auth().currentUser?.uid ?? "impossible to get user")
        
        print("check if user id exists: \(users)") // works
                
        let db = Firestore.firestore()
        
        print("check id database exists: \(db)") // works
        
        db.collection("users").document(users).getDocument { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            print("db.collection")
            print(db.collection("users"))
            print("db.collection.document")
            print(db.collection("users").document(users))
            
            guard let snapshot = snapshot, snapshot.exists else {
                print("Document does not exist")
                return
            }

            let data = snapshot.data() ?? [:] // Provide a default empty dictionary if data is nil

            print("Data retrieved: \(data)")

            DispatchQueue.main.async {
                self?.user = User(email: data["email"] as? String ?? "",
                                  id: data["id"] as? String ?? "",
                                  name: data["name"] as? String ?? "",
                                  surname: data["surname"] as? String ?? ""
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
}

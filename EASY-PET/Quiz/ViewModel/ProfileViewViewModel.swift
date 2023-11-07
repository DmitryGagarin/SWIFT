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
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        print("user id\(userId)")
        
        let db = Firestore.firestore()
        let dbCheck = db.collection("users")
            
        print(db)
        print("swift huesos 1")
        
        print("EBAN BAZA \(db.collection("users").document(userId))")
        
        dbCheck.document(userId).getDocument { [self] snapshot, error in
            print ("cum shot \(snapshot!)")
            if let error = error {
                    print("Error fetching user data: \(error.localizedDescription)")
            } else {
                if snapshot!.exists == true {
                    print("The 'users' collection exists")
                } else {
                    print("The 'users' collection does not exist")
                }
            }
            
            print(snapshot?.data() ?? "PUPUPU")
            
            guard let data = snapshot?.data() else { return
                print("No data or error in Firestore fetch")
            }
            
            print("EBALAI")

            
            DispatchQueue.main.async {
                self.user = User(email: data["email"] as? String ?? "",
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

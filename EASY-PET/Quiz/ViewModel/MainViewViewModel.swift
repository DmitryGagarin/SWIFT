//
//  MainViewViewModel.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 07.11.2023.
//

import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject{
    
    @Published var currentUserId: String = ""
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async { 
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool{
        Auth.auth().currentUser != nil
        
    }
}


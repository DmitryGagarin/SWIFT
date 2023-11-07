//
//  MainViewViewModel.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 07.11.2023.
//

import Foundation
import FirebaseAuth

class MainViewViewModel: ObservableObject {
    
    @Published var currentUserId: String = "" {
        didSet {
            print("currentUserId через didSet в MainViewModel: \(self.currentUserId)")
        }
    }
    
    private var  handler: AuthStateDidChangeListenerHandle?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener {
            [weak self] _, user in DispatchQueue.main.async { [self] in
                self?.currentUserId = user?.uid ?? ""
                print("userId через init() в mainViewModel: \(self!.currentUserId)")
            }
        }
    }
    
    public var isSignedIn: Bool{
        Auth.auth().currentUser != nil
    }
}

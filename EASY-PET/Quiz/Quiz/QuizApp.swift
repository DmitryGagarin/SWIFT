//
//  QuizApp.swift
//  Quiz
//
//  Created by Dmitry Fatsievich on 04.11.2023.
//

import SwiftUI
import Firebase

@main
struct QuizApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

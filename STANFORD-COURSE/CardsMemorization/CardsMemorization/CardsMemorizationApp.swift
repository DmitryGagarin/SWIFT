//
//  CardsMemorizationApp.swift
//  CardsMemorization
//
//  Created by Dmitry Fatsievich on 22.10.2023.
//

import SwiftUI

@main
struct CardsMemorizationApp: App {
    @StateObject var game = MemorizeGameViewModel()
    var body: some Scene {
        WindowGroup {
            MemorizeGameView(viewModel: game)
        }
    }
}

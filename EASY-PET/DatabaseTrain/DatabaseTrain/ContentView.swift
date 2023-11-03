//
//  ContentView.swift
//  DatabaseTrain
//
//  Created by Dmitry Fatsievich on 03.11.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(Group.self) var groups
    
    var body: some View {
        if let group = groups.first {
            ItemListView(group: group)
        } else {
            ProgressView()
                .onAppear {
                    $groups.append(Group())
                }
        }
    }
}

#Preview {
    ContentView()
}

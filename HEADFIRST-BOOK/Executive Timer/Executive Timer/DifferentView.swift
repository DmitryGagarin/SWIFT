//
//  DifferentView.swift
//  Executive Timer
//
//  Created by Dmitry Fatsievich on 20.10.2023.
//

import SwiftUI

struct DifferentView: View {
    var body: some View {
        TabView {
            ContentView()
                .padding()
                .tabItem {
                    Label("Timer View", systemImage: "timer.circle")
                }
            TimerSettingsView()
                .padding()
                .tabItem {
                    Label("Timer Setting", systemImage: "gear")
                }
        }
    }
}

struct DifferentViews_Previews: PreviewProvider {
    static var previews: some View{
        DifferentView()
    }
}


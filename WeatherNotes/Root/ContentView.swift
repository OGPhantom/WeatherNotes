//
//  ContentView.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "list.bullet.rectangle")
                }

//            SettingsView()
//                .tabItem {
//                    Label("Settings", systemImage: "gear.circle")
//                }
        }
        .tint(.accent)
    }
}

#Preview {
    ContentView()
}

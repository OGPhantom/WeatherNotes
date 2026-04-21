//
//  ContentView.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(SettingsStore.self) private var settingsStore

    var body: some View {
        TabView {
            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "list.bullet.rectangle")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear.circle")
                }
        }
        .tint(.accent)
        .preferredColorScheme(settingsStore.appTheme.colorScheme)
    }
}

#Preview {
    ContentView()
        .environment(SettingsStore())
}

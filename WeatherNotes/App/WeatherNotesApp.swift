//
//  WeatherNotesApp.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import SwiftUI
import SwiftData

@main
struct WeatherNotesApp: App {
    @State private var settingsStore = SettingsStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(settingsStore)
        }
        .modelContainer(for: Note.self)
    }
}

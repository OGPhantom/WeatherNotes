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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self)
    }
}

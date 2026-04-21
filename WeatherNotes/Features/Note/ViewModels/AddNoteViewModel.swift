//
//  AddNoteViewModel.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import Foundation
import SwiftData

@Observable
final class AddNoteViewModel {
    var isLoading = false
    var errorMessage: String?

    private var weatherService: WeatherService

    init(weatherService: WeatherService = OpenWeatherService()) {
        self.weatherService = weatherService
    }

    @MainActor
    func saveNote(title: String, content: String, context: ModelContext) async -> Bool {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            let weather = try await weatherService.fetchWeather(
                latitude: 50.4501,
                longitude: 30.5234
            )

            let note = Note(
                title: title,
                content: content,
                weather: weather
            )

            context.insert(note)
            try context.save()

            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}

//
//  SettingsViewModel.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import Foundation

@Observable
final class SettingsViewModel {
    var searchQuery: String = ""

    var isSearching: Bool {
        !searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var ukrainianCities: [WeatherCity] {
        filtered(CityCatalog.cities.filter { $0.country == "Ukraine" })
    }

    var internationalCities: [WeatherCity] {
        filtered(CityCatalog.cities.filter { $0.country != "Ukraine" })
    }

    var searchResults: [WeatherCity] {
        filtered(CityCatalog.cities)
    }

    func filtered(_ weatherCities: [WeatherCity]) -> [WeatherCity] {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return weatherCities }

        return weatherCities.filter {
            $0.name.lowercased().contains(query) ||
            $0.country.lowercased().contains(query) ||
            $0.displayName.lowercased().contains(query)
        }
    }
}

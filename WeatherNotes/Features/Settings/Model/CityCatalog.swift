//
//  CityCatalog.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import Foundation

enum CityCatalog {
    static let defaultCityID = "kyiv"

    static let cities: [WeatherCity] = {
        guard let url = Bundle.main.url(forResource: "Cities", withExtension: "json") else {
            return fallbackCities
        }

        do {
            let data = try Data(contentsOf: url)
            let cities = try JSONDecoder().decode([WeatherCity].self, from: data)
            return cities.isEmpty ? fallbackCities : cities
        } catch {
            return fallbackCities
        }
    }()

    static func city(withID id: String) -> WeatherCity {
        cities.first { $0.id == id } ?? defaultCity
    }

    static var defaultCity: WeatherCity {
        cities.first { $0.id == defaultCityID } ?? fallbackCities[0]
    }

    private static let fallbackCities = [
        WeatherCity(id: "kyiv", name: "Kyiv", country: "Ukraine", latitude: 50.4501, longitude: 30.5234),
        WeatherCity(id: "lviv", name: "Lviv", country: "Ukraine", latitude: 49.8397, longitude: 24.0297),
        WeatherCity(id: "odesa", name: "Odesa", country: "Ukraine", latitude: 46.4825, longitude: 30.7233)
    ]
}

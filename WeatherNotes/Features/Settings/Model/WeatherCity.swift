//
//  WeatherCity.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import Foundation

struct WeatherCity: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double

    var displayName: String {
        "\(name), \(country)"
    }
}

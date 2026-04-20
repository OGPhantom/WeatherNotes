//
//  WeatherResponse.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: [WeatherCondition]
    let main: Main
    let name: String
    let wind: Wind
}

struct WeatherCondition: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Decodable {
    let speed: Double
}

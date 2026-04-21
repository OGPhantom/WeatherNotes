//
//  Weather.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import Foundation
import SwiftUI

struct Weather: Codable {
    let cityName: String
    let conditionCode: Int
    let conditionTitle: String
    let conditionDescription: String
    let temperature: Double
    let feelsLike: Double
    let minTemperature: Double
    let maxTemperature: Double
    let windSpeed: Double
    let humidity: Double
    let pressure: Double

    init(response: WeatherResponse) {
        let primaryCondition = response.weather.first

        cityName = response.name
        conditionCode = primaryCondition?.id ?? 800
        conditionTitle = primaryCondition?.main ?? "Clear"
        conditionDescription = primaryCondition?.description.capitalized ?? "Clear sky"
        temperature = response.main.temp
        feelsLike = response.main.feelsLike
        minTemperature = response.main.tempMin
        maxTemperature = response.main.tempMax
        windSpeed = response.wind.speed
        humidity = response.main.humidity
        pressure = response.main.pressure
    }

    var systemImageName: String {
        switch conditionCode {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "snowflake"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.sun.fill"
        default:
            return "cloud.fill"
        }
    }

    var tint: Color {
        switch conditionCode {
        case 200...232:
            return .purple
        case 300...531:
            return .blue
        case 600...622:
            return .cyan
        case 701...781:
            return .gray
        case 800:
            return .orange
        case 801...804:
            return .teal
        default:
            return .accentColor
        }
    }

    var overviewText: String {
        "Expect \(conditionDescription.lowercased()) with a feels-like temperature of \(feelsLike.temperatureText)."
    }
}

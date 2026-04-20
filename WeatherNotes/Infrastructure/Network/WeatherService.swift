//
//  WeatherService.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import Foundation

protocol WeatherService {
    func fetchWeather(latitude: Double, longitude: Double) async throws -> Weather
}

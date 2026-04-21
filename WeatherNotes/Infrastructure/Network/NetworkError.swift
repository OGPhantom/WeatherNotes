//
//  NetworkError.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//


import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case missingAPIKey
    case badStatusCode(Int)
    case decodingFailed
    case noWeatherData
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The weather request URL is invalid."
        case .invalidResponse:
            return "The weather service returned an invalid response."
        case .missingAPIKey:
            return "OpenWeather API key is missing. Check the app configuration."
        case .badStatusCode(let statusCode):
            return "The weather service returned status code \(statusCode)."
        case .decodingFailed:
            return "Couldn't read the weather response."
        case .noWeatherData:
            return "The weather service didn't return weather data."
        }
    }
}

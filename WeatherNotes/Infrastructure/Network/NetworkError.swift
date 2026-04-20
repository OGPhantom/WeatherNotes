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

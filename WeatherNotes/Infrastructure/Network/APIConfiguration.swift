//
//  APIConfiguration.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import Foundation

enum APIConfiguration {
    static func openWeatherAPIKey() throws -> String {
        let rawValue =  Bundle.main.object(forInfoDictionaryKey: "OpenWeatehrAPIKey") as? String
        let apiKey = rawValue?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !apiKey.isEmpty, !apiKey.contains("$(") else {
            throw NetworkError.missingAPIKey
        }
        
        return apiKey
    }
}

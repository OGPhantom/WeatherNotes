//
//  OpenWeatherService.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import Foundation

struct OpenWeatherService: WeatherService {
    private var session: URLSession
    private var decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchWeather(latitude: Double, longitude: Double) async throws -> Weather {
        //
    }
}

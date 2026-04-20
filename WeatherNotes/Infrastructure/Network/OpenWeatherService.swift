//
//  OpenWeatherService.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import Foundation

struct OpenWeatherService: WeatherService {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchWeather(latitude: Double, longitude: Double) async throws -> Weather {
        let apiKey = try APIConfiguration.openWeatherAPIKey()

        var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        components?.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.badStatusCode(httpResponse.statusCode)
        }

        let weatherResponse: WeatherResponse

        do {
            weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }

        guard !weatherResponse.weather.isEmpty else {
            throw NetworkError.noWeatherData
        }

        return Weather(response: weatherResponse)
    }
}

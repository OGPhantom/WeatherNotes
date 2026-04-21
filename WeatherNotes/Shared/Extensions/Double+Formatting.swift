//
//  Double+Formatting.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import Foundation

extension Double {
    private var roundedString: String {
        String(format: "%.0f", self)
    }

    var temperatureText: String {
        let rounded = roundedString
        return self > 0 ? "+\(rounded)°" : "\(rounded)°"
    }

    var percentageText: String {
        "\(roundedString)%"
    }

    var windSpeedText: String {
        "\(roundedString) m/s"
    }

    var pressureText: String {
        "\(roundedString) hPa"
    }
}

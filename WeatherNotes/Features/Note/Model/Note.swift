//
//  Note.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 20.04.2026.
//

import Foundation
import SwiftData

@Model
final class Note {
    var id: UUID
    var title: String
    var content: String
    var createdAt: Date
    var weather: Weather

    init(id: UUID = UUID(), title: String, content: String, createdAt: Date = .now, weather: Weather) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
        self.weather = weather
    }
}

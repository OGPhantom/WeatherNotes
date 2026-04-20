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

    init(id: UUID, title: String, content: String, createdAt: Date, weather: Weather) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.createdAt = .now
        self.weather = weather
    }
}

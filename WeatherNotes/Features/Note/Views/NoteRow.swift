//
//  NoteRow.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import SwiftUI

struct NoteRow: View {
    @Environment(\.colorScheme) private var colorScheme
    let note: Note

    var body: some View {
        HStack(spacing: 12) {
            weatherIcon

            noteInfo

            Spacer(minLength: 8)

            temperatureBadge
        }
        .contentShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding(.leading, 12)
        .padding(.trailing, 14)
        .padding(.vertical, 14)
        .background(CardBackground())
    }
}

private extension NoteRow {
    var weatherIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(note.weather.tint.opacity(colorScheme == .dark ? 0.20 : 0.12))

            Image(systemName: note.weather.systemImageName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(note.weather.tint)
                .symbolRenderingMode(.hierarchical)
        }
        .frame(width: 40, height: 40)
        .accessibilityLabel(note.weather.conditionDescription)
    }
    
    var noteInfo: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(note.title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.primary)
                .lineLimit(1)

            Text(note.content.isEmpty ? "No details" : note.content)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }

    var temperatureBadge: some View {
        VStack(alignment: .trailing) {
            Text(note.weather.temperature.temperatureText)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(note.weather.tint)
                .monospacedDigit()
                .lineLimit(1)


            Text(note.createdAt.formatted(.dateTime.day().month(.abbreviated).hour().minute()))
                            .lineLimit(1)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NoteRow(
        note: Note(
            title: "Do sth",
            content: "Do sth very important.",
            weather: Weather(
                response: WeatherResponse(
                    weather: [
                        WeatherCondition(
                            id: 800,
                            main: "Clear",
                            description: "clear sky",
                            icon: "01d"
                        )
                    ],
                    main: Main(
                        temp: 12,
                        feelsLike: 10,
                        tempMin: 9,
                        tempMax: 14,
                        pressure: 1012,
                        humidity: 64
                    ),
                    name: "Kyiv",
                    wind: Wind(speed: 3)
                )
            )
        )
    )
}

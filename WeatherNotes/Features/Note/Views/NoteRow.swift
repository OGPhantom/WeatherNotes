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

            Spacer(minLength: 12)

            temperature
        }
        .contentShape(Rectangle())
        .padding(20)
        .background(rowBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}

private extension NoteRow {
    var weatherIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(note.weather.tint.opacity(0.16))

            Image(systemName: note.weather.systemImageName)
                .font(.system(size: 44 * 0.48, weight: .semibold))
                .foregroundStyle(note.weather.tint)
                .symbolRenderingMode(.hierarchical)
        }
        .frame(width: 44, height: 44)
        .accessibilityLabel(note.weather.conditionDescription)
    }
    
    var noteInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(note.title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.primary)
                .lineLimit(1)

            Text(note.createdAt.formatted(.dateTime.day().month(.abbreviated).hour().minute()))
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }

    var temperature: some View {
        Text(note.weather.temperature.temperatureText)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundStyle(.primary)
            .monospacedDigit()
            .lineLimit(1)
    }

    var rowBackground: some ShapeStyle {
        if colorScheme == .dark {
            return Color.white.opacity(0.06)
        }

        return Color(.secondarySystemGroupedBackground)
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

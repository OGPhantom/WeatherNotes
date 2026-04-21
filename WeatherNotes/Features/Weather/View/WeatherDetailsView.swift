//
//  WeatherDetailsView.swift
//  WeatherNotes
//
//  Created by Codex on 21.04.2026.
//

import SwiftUI

struct WeatherDetailsView: View {
    let weather: Weather

    var body: some View {
        ScrollView {
            WeatherDetailsContent(weather: weather)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 28)
        }
        .scrollIndicators(.hidden)
    }
}

struct WeatherDetailsContent: View {
    let weather: Weather

    private let metricColumns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            heroSection
            metricsSection
        }
    }
}

private extension WeatherDetailsContent {
    var heroSection: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(weather.cityName)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.82)

                    Label(weather.conditionDescription, systemImage: weather.systemImageName)
                        .font(.headline)
                        .foregroundStyle(weather.tint.opacity(0.8))
                        .lineLimit(2)
                }

                Text(weather.temperature.temperatureText)
                    .font(.system(size: 90, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .monospacedDigit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                VStack(spacing: 10) {
                    HStack {
                        temperatureEdge(
                            title: "Low",
                            value: weather.minTemperature.temperatureText,
                            alignment: .leading
                        )

                        Spacer(minLength: 18)

                        temperatureEdge(
                            title: "High",
                            value: weather.maxTemperature.temperatureText,
                            alignment: .trailing
                        )
                    }

                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    .blue.opacity(0.85),
                                    .cyan.opacity(0.85),
                                    weather.tint.opacity(0.85),
                                    .yellow.opacity(0.85)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 6)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(24)
        .background(CardBackground())
    }

    func temperatureEdge(title: String, value: String, alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: 4) {
            Text(title.uppercased())
                .font(.caption2.weight(.semibold))
                .foregroundStyle(.secondary.opacity(0.8))

            Text(value)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundStyle(.primary)
                .monospacedDigit()
                .lineLimit(1)
        }
    }

    var metricsSection: some View {
        LazyVGrid(columns: metricColumns, spacing: 10) {
            metricTile(
                title: "Feels like",
                value: weather.feelsLike.temperatureText,
                symbol: "thermometer.medium",
                tint: .orange
            )

            metricTile(
                title: "Humidity",
                value: weather.humidity.percentageText,
                symbol: "humidity.fill",
                tint: .cyan
            )

            metricTile(
                title: "Wind",
                value: weather.windSpeed.windSpeedText,
                symbol: "wind",
                tint: .teal
            )

            metricTile(
                title: "Pressure",
                value: weather.pressure.pressureText,
                symbol: "barometer",
                tint: .indigo
            )
        }
    }

    func metricTile(title: String, value: String, symbol: String, tint: Color) -> some View {
        HStack(spacing: 12) {
            Image(systemName: symbol)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(tint)
                .frame(width: 32, height: 32)
                .background {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(tint.opacity(0.12))
                }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                Text(value)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                    .monospacedDigit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.78)
            }

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 72, alignment: .leading)
        .padding(.horizontal, 12)
        .background(CardBackground())
    }
}

#Preview {
    NavigationStack {
        WeatherDetailsView(
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
    }
}

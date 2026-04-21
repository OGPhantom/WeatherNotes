//
//  SettingsView.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import SwiftUI

struct SettingsView: View {
    @Environment(SettingsStore.self) private var settingsStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    themeSection
                    citySection
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
            .scrollIndicators(.hidden)
            .background(AppBackground())
            .navigationTitle("Settings")
        }
    }
}

private extension SettingsView {
    var selectedTheme: Binding<AppTheme> {
        Binding {
            settingsStore.appTheme
        } set: { theme in
            settingsStore.appTheme = theme
        }
    }

    var selectedCity: WeatherCity {
        settingsStore.selectedCity
    }

    var themeSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionHeader(title: "Appearance", systemImage: "circle.lefthalf.filled")

            Picker("Theme", selection: selectedTheme) {
                ForEach(AppTheme.allCases) { theme in
                    Text(theme.title)
                        .tag(theme)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(18)
        .background(CardBackground())
    }

    var citySection: some View {
        NavigationLink {
            WeatherCityView()
        } label: {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.accentColor.opacity(0.14))

                    Image(systemName: "location.fill")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.accent)
                }
                .frame(width: 42, height: 42)

                VStack(alignment: .leading, spacing: 3) {
                    Text("Weather City")
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.secondary)

                    Text(selectedCity.displayName)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                }

                Spacer(minLength: 12)

                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(18)
            .background(CardBackground())
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
    }

    func sectionHeader(title: String, systemImage: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: systemImage)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.accent)
                .frame(width: 24, height: 24)

            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    SettingsView()
        .environment(SettingsStore())
}

//
//  WeatherCityView.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import SwiftUI

struct WeatherCityView: View {
    @Environment(SettingsStore.self) private var settings
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = SettingsViewModel()
    @State private var isUkraineExpanded = false

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                if viewModel.isSearching {
                    section(title: "Search results", cities: viewModel.searchResults)
                } else {
                    ukraineSection
                    section(title: "International", cities: viewModel.internationalCities)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 40)
        }
        .scrollIndicators(.hidden)
        .background(AppBackground())
        .navigationTitle("Weather City")
        .searchable(
            text: $viewModel.searchQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search city"
        )
    }
}

private extension WeatherCityView {
    @ViewBuilder
    var ukraineSection: some View {
        if hiddenUkraineCityCount > 0 {
            section(
                title: "Ukraine",
                cities: visibleUkrainianCities,
                footer: ukraineToggle
            )
        } else {
            section(title: "Ukraine", cities: visibleUkrainianCities)
        }
    }

    var visibleUkrainianCities: [WeatherCity] {
        isUkraineExpanded
        ? viewModel.ukrainianCities
        : Array(viewModel.ukrainianCities.prefix(4))
    }

    var hiddenUkraineCityCount: Int {
        max(viewModel.ukrainianCities.count - 4, 0)
    }

    @ViewBuilder
    var ukraineToggle: some View {
        if hiddenUkraineCityCount > 0 {
            Button {
                withAnimation(.spring(duration: 0.25)) {
                    isUkraineExpanded.toggle()
                }
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: isUkraineExpanded ? "chevron.up" : "chevron.down")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.accent)
                        .frame(width: 40)

                    Text(isUkraineExpanded ? "Show less" : "Show \(hiddenUkraineCityCount) more")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.accent)

                    Spacer()
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 14)
                .padding(.vertical, 13)
            }
            .buttonStyle(.plain)
        }
    }

    func section(title: String, cities: [WeatherCity]) -> some View {
        sectionContainer(title: title, cities: cities) {
            cityList(cities)
        }
    }

    func section<Footer: View>(title: String, cities: [WeatherCity], footer: Footer) -> some View {
        sectionContainer(title: title, cities: cities) {
            cityList(cities, footer: footer)
        }
    }

    func sectionContainer<Content: View>(title: String, cities: [WeatherCity], content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .padding(.horizontal, 4)

            if cities.isEmpty {
                emptySearchRow
            } else {
                content()
                    .background(CardBackground())
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
        }
    }

    func cityList(_ cities: [WeatherCity]) -> some View {
        VStack(spacing: 0) {
            cityRows(cities)
        }
    }

    func cityList<Footer: View>(_ cities: [WeatherCity], footer: Footer) -> some View {
        VStack(spacing: 0) {
            cityRows(cities)

            Divider()
                .padding(.leading, 56)

            footer
        }
    }

    func cityRows(_ cities: [WeatherCity]) -> some View {
        ForEach(cities) { city in
            cityRow(city)

            if city != cities.last {
                Divider()
                    .padding(.leading, 56)
            }
        }
    }

    func cityRow(_ city: WeatherCity) -> some View {
        let isSelected = settings.selectedCityID == city.id

        return Button {
            withAnimation(.spring(duration: 0.25)) {
                settings.selectedCityID = city.id
            }
        } label: {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(isSelected ? Color.accentColor.opacity(0.18) : Color.secondary.opacity(0.10))

                    Image(systemName: "location.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(isSelected ? Color.accentColor : Color.secondary)
                }
                .frame(width: 40, height: 40)

                VStack(alignment: .leading, spacing: 3) {
                    Text(city.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)

                    Text(city.country)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer(minLength: 12)

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.accent)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .contentShape(Rectangle())
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
        }
        .buttonStyle(.plain)
    }

    var emptySearchRow: some View {
        Text("No cities found")
            .font(.system(size: 15, weight: .medium))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(18)
            .background(CardBackground())
    }
}

#Preview {
    WeatherCityView()
        .environment(SettingsStore())
}

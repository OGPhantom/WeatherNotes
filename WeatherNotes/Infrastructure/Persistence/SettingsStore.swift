//
//  SettingsStore.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import Foundation

@Observable
final class SettingsStore {
    private let userDefaults: UserDefaults

    var appTheme: AppTheme {
        didSet {
            userDefaults.set(appTheme.rawValue, forKey: AppStorageKeys.appTheme)
        }
    }

    var selectedCityID: String {
        didSet {
            userDefaults.set(selectedCityID, forKey: AppStorageKeys.selectedCityID)
        }
    }

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults

        let storedTheme = userDefaults.string(forKey: AppStorageKeys.appTheme)
        appTheme = AppTheme(rawValue: storedTheme ?? "") ?? .system

        let storedCityID = userDefaults.string(forKey: AppStorageKeys.selectedCityID)
        let cityID = storedCityID ?? CityCatalog.defaultCityID
        selectedCityID = CityCatalog.cities.contains { $0.id == cityID } ? cityID : CityCatalog.defaultCityID
    }

    var selectedCity: WeatherCity {
        CityCatalog.city(withID: selectedCityID)
    }
}

//
//  NoteViewModel.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import Foundation

@Observable
final class NoteViewModel {
    var searchQuery: String = ""

    func filtered(_ notes: [Note]) -> [Note] {
        guard !searchQuery.isEmpty else { return notes }

        let query = searchQuery.lowercased()

        let filteredNotes = notes.filter {
            $0.title.lowercased().contains(query) ||
            $0.content.lowercased().contains(query)
        }

        return filteredNotes
    }
}

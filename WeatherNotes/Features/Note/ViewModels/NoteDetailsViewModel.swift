//
//  NoteDetailsViewModel.swift
//  WeatherNotes
//
//  Created by Codex on 21.04.2026.
//

import Foundation
import SwiftData

@Observable
final class NoteDetailsViewModel {
    var title: String
    var content: String
    var errorMessage: String?

    private let note: Note

    init(note: Note) {
        self.note = note
        title = note.title
        content = note.content
    }

    var hasChanges: Bool {
        title != note.title || content != note.content
    }

    var canSave: Bool {
        !trimmedTitle.isEmpty && hasChanges
    }

    var createdAtText: String {
        note.createdAt.formatted(.dateTime.day().month(.wide).year().hour().minute())
    }

    @MainActor
    func save(context: ModelContext) -> Bool {
        let newTitle = trimmedTitle
        let newContent = content.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !newTitle.isEmpty else {
            errorMessage = "Title cannot be empty."
            return false
        }

        note.title = newTitle
        note.content = newContent

        do {
            try context.save()
            title = newTitle
            content = newContent
            errorMessage = nil
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    @MainActor
    func delete(context: ModelContext) -> Bool {
        context.delete(note)

        do {
            try context.save()
            errorMessage = nil
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func resetChanges() {
        title = note.title
        content = note.content
        errorMessage = nil
    }
}

private extension NoteDetailsViewModel {
    var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

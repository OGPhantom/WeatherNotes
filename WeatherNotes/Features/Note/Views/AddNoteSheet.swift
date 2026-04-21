//
//  AddNoteSheet.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import SwiftUI

struct AddNoteSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var titleOfNote: String = ""
    @State private var contentOfNote: String = ""

    var body: some View {
        NavigationStack {
            Form {
                title

                content
            }
            .navigationTitle("Add a note")
            .toolbar { toolbar }
        }
    }
}

private extension AddNoteSheet {
    private var canSave: Bool {
        !titleOfNote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var toolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.system(size: 18, weight: .semibold))
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button {
//                    viewModel.saveNote(text: text, context: modelContext)
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.system(size: 18, weight: .semibold))
                }
                .disabled(!canSave)
            }
        }
    }

    private var title: some View {
        TextField("Note Title", text: $titleOfNote)
            .padding(8)
    }

    private var content: some View {
        ZStack(alignment: .topLeading) {
            if contentOfNote.isEmpty {
                Text("Add details of your note if needed")
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary.opacity(0.5))
                    .padding(.top, 14)
                    .padding(.leading, 8)
            }

            TextEditor(text: $contentOfNote)
                .scrollContentBackground(.hidden)
                .frame(minHeight: 112)
                .font(.system(size: 15))
                .foregroundStyle(.primary)
                .padding(8)
        }
    }
}

#Preview {
    AddNoteSheet()
}

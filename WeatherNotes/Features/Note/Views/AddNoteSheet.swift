//
//  AddNoteSheet.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import SwiftUI
import SwiftData

struct AddNoteSheet: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var titleOfNote: String = ""
    @State private var contentOfNote: String = ""

    @State private var viewModel = AddNoteViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    title

                    content
                }
                .padding()
            }
            .background(AppBackground())
            .navigationTitle("Add a note")
            .toolbar { toolbar }
            .alert(
                "Couldn't save note",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { isPresented in
                        if !isPresented {
                            viewModel.errorMessage = nil
                        }
                    }
                )
            ) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "Please try again.")
            }
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
                .disabled(viewModel.isLoading)
            }

            ToolbarItem(placement: .confirmationAction) {
                Button {
                    Task {
                        let didSave = await viewModel.saveNote(
                            title: titleOfNote,
                            content: contentOfNote,
                            context: modelContext
                        )

                        if didSave {
                            dismiss()
                        }
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Done")
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
                .disabled(!canSave || viewModel.isLoading)
            }
        }
    }

    private var title: some View {
        VStack(alignment: .leading){
            TextField("Note Title", text: $titleOfNote)
                .padding(8)
        }
        .padding(20)
        .background(CardBackground())
    }

    private var content: some View {
        ZStack(alignment: .topLeading) {
            if contentOfNote.isEmpty {
                Text("Add details of your note if needed")
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary.opacity(0.5))
                    .padding(.top, 14)
                    .padding(.leading, 14)
            }

            TextEditor(text: $contentOfNote)
                .scrollContentBackground(.hidden)
                .frame(minHeight: 112)
                .font(.system(size: 15))
                .foregroundStyle(.primary)
                .padding(8)
        }
        .padding(20)
        .background(CardBackground())
    }
}

#Preview {
    AddNoteSheet()
}

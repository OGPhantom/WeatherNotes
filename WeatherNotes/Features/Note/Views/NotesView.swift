//
//  NotesView.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import SwiftUI
import SwiftData

struct NotesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Note.createdAt, order: .reverse) private var notes: [Note]
    @State private var viewModel = NoteViewModel()
    @State private var showingAdd = false

    @State private var detailsOfNote: Note?

    var body: some View {
        NavigationStack {
            Group {
                if notes.isEmpty {
                    emptyState
                } else {
                    notesList
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(AppBackground())
            .navigationTitle("Notes")
            .sheet(isPresented: $showingAdd, content: {
                AddNoteSheet()
            })
            .sheet(item: $detailsOfNote) { note in
                NoteDetailsView(note: note)
            }
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Searсh notes")
        }
        .overlay(alignment: .bottomTrailing) { button }
    }
}

private extension NotesView {
    var button: some View {
        Button {
            showingAdd = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.white)
                .padding(16)
                .background(
                    Circle()
                        .fill(.accent)
                        .shadow(
                            color: .accent,
                            radius: 8,
                            x: 0,
                            y: 4
                        )
                )
        }
        .padding(.trailing, 20)
        .padding(.bottom, 10)
    }

    private var filteredNotes: [Note] {
        viewModel.filtered(notes)
    }

    var notesList: some View {
        ScrollView {
            ForEach(filteredNotes) { note in
                Button {
                    detailsOfNote = note
                } label: {
                    NoteRow(note: note)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 120)
        }
        .scrollIndicators(.hidden)
    }

    var emptyState: some View {
        ContentUnavailableView("No Notes", systemImage: "tray", description: Text("Add your first note to get started"))
            .padding()
    }
}


#Preview {
    NotesView()
}

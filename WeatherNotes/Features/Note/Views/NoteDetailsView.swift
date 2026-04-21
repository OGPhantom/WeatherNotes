//
//  NoteDetailsView.swift
//  WeatherNotes
//
//  Created by Никита Сторчай on 21.04.2026.
//

import SwiftUI
import SwiftData

struct NoteDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let note: Note
    @State private var viewModel: NoteDetailsViewModel

    init(note: Note) {
        self.note = note
        _viewModel = State(initialValue: NoteDetailsViewModel(note: note))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    NoteEditorView(
                        viewModel: viewModel,
                        onSave: saveNote,
                        onReset: viewModel.resetChanges
                    )

                    WeatherDetailsContent(weather: note.weather)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 28)
            }
            .scrollIndicators(.hidden)
            .background(AppBackground())
            .navigationTitle("Note Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbar }
            .alert(
                "Note Error",
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
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

private extension NoteDetailsView {
    func saveNote() {
        _ = viewModel.save(context: modelContext)
    }

    func deleteNote() {
        if viewModel.delete(context: modelContext) {
            dismiss()
        }
    }

    var toolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.primary)
                }
            }

            ToolbarItem(placement: .bottomBar) {
                Button {
                    deleteNote()
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.red)
                }
            }
        }
    }
}
#Preview {
    NoteDetailsView(note:
                        Note(
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

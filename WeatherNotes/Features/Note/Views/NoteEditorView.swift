//
//  NoteEditorView.swift
//  WeatherNotes
//
//  Created by Codex on 21.04.2026.
//

import SwiftUI

struct NoteEditorView: View {
    @Bindable var viewModel: NoteDetailsViewModel
    let onSave: () -> Void
    let onReset: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            titleField
            contentEditor
            actions
        }
        .padding(18)
        .background(CardBackground(cornerRadius: 8))
    }
}

private extension NoteEditorView {
    var header: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Note")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)

            Text(viewModel.createdAtText)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    var titleField: some View {
        TextField("Title", text: $viewModel.title, axis: .vertical)
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .foregroundStyle(.primary)
            .lineLimit(1...3)
            .textInputAutocapitalization(.sentences)
            .submitLabel(.done)
            .padding(.vertical, 4)
    }

    var contentEditor: some View {
        ZStack(alignment: .topLeading) {
            if viewModel.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text("Write note text")
                    .font(.body)
                    .foregroundStyle(.secondary.opacity(0.75))
                    .padding(.top, 9)
                    .padding(.leading, 5)
                    .allowsHitTesting(false)
            }

            TextEditor(text: $viewModel.content)
                .font(.body)
                .foregroundStyle(.primary)
                .scrollContentBackground(.hidden)
                .frame(minHeight: 150)
                .padding(.horizontal, -5)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.primary.opacity(0.04))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.06), lineWidth: 1)
        }
    }

    @ViewBuilder
    var actions: some View {
        if viewModel.hasChanges {
            HStack(spacing: 10) {
                Button("Reset") {
                    onReset()
                }
                .buttonStyle(.borderless)
                .foregroundStyle(.secondary)

                Spacer(minLength: 12)

                Button {
                    onSave()
                } label: {
                    Label("Save", systemImage: "checkmark")
                        .font(.system(size: 15, weight: .semibold))
                }
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.canSave)
            }
        }
    }
}

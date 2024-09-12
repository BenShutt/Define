//
//  Word+Preview.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import SwiftUI
import SwiftData
import DictionaryAPI
import Utilities

// MARK: - WordPreview

@MainActor
class WordPreview: ObservableObject {
    @Published var word: Word?
    @Published var isLoading = false

    init(word: String) {
        Task {
            do {
                try await load(term: word)
            } catch {
                log(error: error)
            }
        }
    }

    private func load(term: String) async throws {
        isLoading = true
        defer { isLoading = false }

        let words = try await GetWords(word: term).request()
        word = try words.first ?! WordPreviewError.empty
    }
}

// MARK: - WordPreviewView

struct WordPreviewView<Content: View>: View {
    @StateObject private var preview: WordPreview
    @ViewBuilder var content: (Word) -> Content

    init(
        word: String,
        @ViewBuilder content: @escaping (Word) -> Content
    ) {
        _preview = .init(wrappedValue: .init(word: word))
        self.content = content
    }

    var body: some View {
        if preview.isLoading {
            ProgressView()
        } else if let word = preview.word {
            content(word)
        }
    }
}

// MARK: - WordPreviewError

enum WordPreviewError: Error {
    case empty
}

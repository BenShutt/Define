//
//  WordScreen.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI

/// `View` to input a word to search for definitions
struct WordScreen: Screen {

    /// Presentation mode
    @Environment(\.dismiss) var dismiss

    /// Result of the `EntriesAPI`
    @State private var entriesResult: ModelResult<Entries>?

    /// `Word` to define
    var word: Word

    /// Loading while the `entriesResult` is `nil`
    var isLoading: Bool {
        entriesResult == nil
    }

    /// `Entries` for `word` returned from the API
    var definitions: [String] {
        entriesResult?.success?.definitions ?? []
    }

    /// `View` of the screen
    var screenBody: some View {
        Group {
            if isLoading {
                LoadingView()
            } else if definitions.isEmpty {
                NoDefinitionsView(
                    word: word.word,
                    isAPIError: entriesResult?.failure != nil
                )
            } else {
                StickyButtonScreen(buttonText: .WordScreen.saveButton) {
                    // TODO on button tap
                    dismiss()
                } content: {
                    DefinitionsView(word: word, definitions: definitions)
                }
            }
        }
        .onAppear {
            EntriesAPI(wordId: word.id).request { result in
                entriesResult = result.modelResult()
            }
        }
    }

    /// Save the given `word`
    /// - Parameter word: `Word`
    private func saveWord(word: Word) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}

// MARK: - DefinitionsView

/// Draws a list of definitions
struct DefinitionsView: View {

    /// Word to define
    var word: Word

    /// The definitions
    var definitions: [String]

    /// Draw `View`
    var body: some View {
        VStack(spacing: 0) {
            Text(word.title)
                .h1()

            ListView(definitions) { definition in
                Text(definition)
                    .body()
                    .listItem()
                    .padding(.margins)
            }
        }
    }
}

// MARK: - NoDefinitionsView

/// Draw empty state when no definitions can be found
private struct NoDefinitionsView: View {

    /// Word that was searched
    var word: String

    /// Was there an API error
    var isAPIError: Bool

    /// Title text
    var title: String {
        isAPIError ? .WordScreen.Error.title : .WordScreen.Empty.title
    }

    /// Subtitle text
    var subtitle: String {
        isAPIError ?
            .WordScreen.Error.subtitle(word: word) :
                .WordScreen.Empty.subtitle(word: word)
    }

    /// Make a `SearchEmptyView`
    var body: some View {
        SearchEmptyView(
            lottie: .searchNoResults,
            title: title,
            subtitle: subtitle
        )
    }
}

// MARK: - PreviewProvider

struct WordScreen_Previews: PreviewProvider {
    static var previews: some View {
        WordScreen(word: .preview)
    }
}

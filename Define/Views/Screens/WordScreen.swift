//
//  WordScreen.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI

/// `View` to input a word to search for definitions
struct WordScreen: Screen {

    /// `Word` to define
    var word: Word

    /// Result of the `EntriesAPI`
    @State private var entriesResult: ModelResult<Entries>?

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
            } else {
                if !definitions.isEmpty {
                    List(definitions, id: \.self) { defintion in
                        Text(defintion)
                            .body()
                    }
                    // ButtonView(text: .WordScreen.saveButton) {
                    //    saveWord(word: word)
                    // }
                } else {
                    NoDefinitionsView(
                        word: word.word,
                        isAPIError: entriesResult?.failure != nil
                    )
                }
            }
        }
        .padding(.margins)
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

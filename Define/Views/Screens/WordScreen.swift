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

    /// Did the API error
    var isAPIError: Bool {
        entriesResult?.failure != nil
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
                } else if isAPIError {
                    SearchEmpty() // TODO localizations
                } else {
                    SearchNoResults(word: word.word) // TODO localizations
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

//
//  LookUp.swift
//  Define
//
//  Created by Ben Shutt on 19/09/2022.
//

import Foundation

/// Look up the definition of a word
struct LookUp {

    /// Completion handler
    typealias Completion = (Result<Entries, Error>) -> Void

    /// Get `Entries` for the given `word`
    ///
    /// - Parameters:
    ///   - word: `String`
    ///   - completion: `Completion`
    static func entries(for word: String, completion: @escaping Completion) {
        // Hit search API
        SearchAPI(word: word).request { result in
            let modelResult: ModelResult<Words> = result.modelResult()
            switch modelResult {
            case let .success(words):
                entries(for: words, completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    /// Get `Entries` for the given `words`
    ///
    /// - Parameters:
    ///   - words: `Words`
    ///   - completion: `Completion`
    private static func entries(for words: Words, completion: @escaping Completion) {
        // Get the word with the max score
        let maxWord = words.results.max { $0.score < $1.score }
        guard let wordId = maxWord?.id else {
            completion(.failure(LookUpError.noResults))
            return
        }

        // Hit entries API
        EntriesAPI(wordId: wordId).request { result in
            completion(result.modelResult())
        }
    }
}

// MARK: - LookUpError

/// `Error` with `LookUp`
enum LookUpError: Error {

    /// Search returned no results
    case noResults
}

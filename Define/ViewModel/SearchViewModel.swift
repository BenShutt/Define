//
//  SearchViewModel.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import Combine
import SwiftUI
import DictionaryAPI

/// View model wrapper of the `SearchAPI`
@MainActor final class SearchViewModel: ObservableObject {

    /// Search state
    enum State {

        /// No text to search
        case emptySearch

        /// The search task is in progress
        case loading

        /// Failed to load search results
        case failure(Error)

        /// Successfully loaded words for search
        case success([Word])
    }

    /// The text being searched
    @Published var search = ""

    /// The text being searched
    @Published var state: State = .emptySearch

    /// `Set` of `AnyCancellable`
    private var cancellables = Set<AnyCancellable>()

    /// `[Word]` returned from the API
    var words: [Word] {
        guard case .success(let words) = state else { return [] }
        return words.sorted(by: <)
    }

    /// Construct a publisher for the search text
    private var searchPublisher: AnyPublisher<String, Never> {
        $search
            .map { $0.trimmed }
            .dropFirst()
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    /// Check if the given `search` is still valid
    /// - Parameter search: `String`
    /// - Returns: `Bool`
    private func isSearchStillValid(_ search: String) -> Bool {
        search.trimmed == self.search.trimmed
    }

    /// Initialize setting up Combine publish events
    init() {
        searchPublisher
            .receive(on: RunLoop.main)
            .sink { search in
                self.state = search.isEmpty ? .emptySearch : .loading
            }
            .store(in: &cancellables)

        searchPublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { search in
                self.getWords(for: search)
            }
            .store(in: &cancellables)
    }

    /// Fetch words from the API
    /// - Parameter search: `Search`
    private func getWords(for search: String) {
        guard !search.isEmpty else { return }
        guard isSearchStillValid(search) else { return }

        Task {
            do {
                let words = try await GetWords.request(word: search)
                guard !words.isEmpty else { throw SearchViewModelError.noResults }
                setState(.success(words), for: search)
            } catch {
                setState(.failure(error), for: search)
            }
        }
    }

    /// Set `state` for the given `search`.
    /// Does nothing if the `search` is out of date.
    /// - Parameters:
    ///   - state: `State`
    ///   - search: `String`
    private func setState(_ state: State, for search: String) {
        guard isSearchStillValid(search) else { return }
        self.state = state
    }
}

// MARK: - SearchViewModelError

/// Error with `SearchViewModel`
enum SearchViewModelError: Error {

    /// No results found for the search
    case noResults
}

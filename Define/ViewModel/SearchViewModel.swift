//
//  SearchViewModel.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import Combine
import SwiftUI
import DictionaryAPI

/// Observable that fetches words from the API when the search updates
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

    /// Number of milliseconds to debounce the search
    private let debounceMilliseconds = 500

    /// The text being searched
    @Published var search = ""

    /// The text being searched
    @Published private(set) var state: State = .emptySearch

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
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    /// Check if the given `search` is still valid
    /// - Parameter search: `String`
    /// - Returns: `Bool`
    private func isSearchStillValid(_ search: String) -> Bool {
        search.caseInsensitiveCompare(self.search.trimmed) == .orderedSame
    }

    /// Initialize setting up Combine publish events
    init() {
        searchPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] search in
                self?.state = search.isEmpty ? .emptySearch : .loading
            }
            .store(in: &cancellables)

        searchPublisher
            .debounce(
                for: .milliseconds(debounceMilliseconds),
                scheduler: DispatchQueue.main
            )
            .sink { [weak self] search in
                Task { await self?.refresh(for: search) }
            }
            .store(in: &cancellables)
    }

    /// Fetch words from the API
    /// - Parameter search: `Search`
    private func refresh(for search: String) async {
        var state: State
        do {
            guard !search.isEmpty else { return }
            guard isSearchStillValid(search) else { return }
            let words = try await GetWords(word: search).requestAndValidate()
            guard !words.isEmpty else { throw SearchViewModelError.noResults }
            state = .success(words)
        } catch {
            log(error: error)
            state = .failure(error)
        }

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

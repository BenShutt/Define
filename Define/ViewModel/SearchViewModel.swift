//
//  SearchViewModel.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import Combine
import SwiftUI
import DictionaryAPI
import Alamofire

/// View model wrapper of the `SearchAPI`
@MainActor final class SearchViewModel: ObservableObject {

    /// Search state
    enum State {

        /// Is loading results
        case loading

        /// Is showing non-empty list
        case list

        /// Empty list
        case noResults

        /// Text is empty
        case empty
    }

    /// Minimum score required
    private static let scoreMin: Double = 50

    /// Debounce throttle on the search
    private static let debounce: TimeInterval = .debounce

    /// Text being searched
    @Published var searchText = ""

    /// Definitions of word
    @Published private(set) var result = emptyTextResult

    /// Is API loading
    @Published private(set) var isLoading = false

    /// `Set` of `AnyCancellable`
    private var cancellables = Set<AnyCancellable>()

    /// Result when there is no text to search
    private static var emptyTextResult: ModelResult<[Word]> {
        .failure(SearchViewModelError.emptyText)
    }

    /// Publisher of `$searchText`
    private var searchTextPublisher: AnyPublisher<String, Never> {
        $searchText
            .dropFirst()
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    // MARK: - Init

    /// Initializer
    init() {
        // Handle changes to searchText
        searchTextPublisher.sinkAndStore(in: &cancellables) { [weak self] _ in
            self?.isLoading = !(self?.searchText ?? "").isEmpty
            self?.result = Self.emptyTextResult
        }

        // Handle debounced changes to searchText
        searchTextPublisher
            .debounce(for: .seconds(Self.debounce), scheduler: DispatchQueue.main)
            .sinkAndStore(in: &cancellables) { [weak self] word in
                guard !word.isEmpty else { return }
                guard word == self?.searchText else { return } // Outdated
                self?.search(word: word)
            }
    }

    /// Search for `word`
    /// - Parameter word: `String`
    private func search(word: String) {
        Task {
            let result: ModelResult<[Word]>
            do {
                let words = try await EntriesAPI.request(word: word)
                result = .success(words)
            } catch {
                result = .failure(error)
            }

            guard searchText == word else { return } // Outdated
            isLoading = false
            self.result = result
        }
    }

    // MARK: - State

    /// `[Word]` returned from the API
    var words: [Word] {
        (result.success ?? []).sorted(by: <)
    }

    /// Get `State`
    var state: State {
        if isLoading {
            return .loading
        } else if !words.isEmpty {
            return .list
        } else if !searchText.isEmpty {
            return .noResults
        }
        return .empty
    }
}

// MARK: - SearchViewModelError

/// Error with `SearchViewModel`
enum SearchViewModelError: Error {

    /// No text to search
    case emptyText
}

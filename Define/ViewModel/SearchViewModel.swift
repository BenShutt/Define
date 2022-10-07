//
//  SearchViewModel.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import Combine
import SwiftUI

/// View model wrapper of the `SearchAPI`
class SearchViewModel: ObservableObject {

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
    private static var emptyTextResult: ModelResult<Words> {
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
            .sinkAndStore(in: &cancellables) { [weak self] value in
                guard !value.isEmpty else { return }
                guard value == self?.searchText else { return } // Outdated
                self?.lookUp(word: value)
            }
    }

    // MARK: - API

    /// Look up definitions for `word`
    ///
    /// - Parameter word: `String`
    private func lookUp(word: String) {
        SearchAPI(word: word).request { [weak self] result in
            guard word == self?.searchText else { return } // Outdated
            self?.isLoading = false
            self?.result = result.modelResult()
        }
    }
}

// MARK: - SearchViewModelError

/// Error with `SearchViewModel`
enum SearchViewModelError: Error {

    /// No text to search
    case emptyText
}

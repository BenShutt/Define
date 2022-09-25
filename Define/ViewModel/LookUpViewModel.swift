//
//  LookUpViewModel.swift
//  Define
//
//  Created by Ben Shutt on 19/09/2022.
//

import Foundation
import SwiftUI
import Combine

/// View model wrapper of the `LookUp` API
class LookUpViewModel: ObservableObject {

    /// Debounce throttle on the search
    private static let debounce: TimeInterval = 1

    /// Text being searched
    @Published var searchText = ""

    /// Definitions of word
    @Published private(set) var result = emptyTextResult

    /// Is API loading
    @Published private(set) var isLoading = false

    /// `Set` of `AnyCancellable`
    private var cancellables = Set<AnyCancellable>()

    /// Result when there is no text to search
    private static var emptyTextResult: Result<Entries, Error> {
        .failure(LookUpViewModelError.emptyText)
    }

    /// Initializer
    init() {
        // Handle changes to searchText
        searchTextPublisher
            .sink { [weak self] _ in
                self?.isLoading = !(self?.searchText ?? "").isEmpty
                self?.result = Self.emptyTextResult
            }
            .store(in: &cancellables)

        // Handle debounced changes to searchText
        searchTextPublisher
            .debounce(for: .seconds(Self.debounce), scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                guard !value.isEmpty else { return }
                guard value == self?.searchText else { return } // Outdated
                self?.lookUp(word: value)
            }
            .store(in: &cancellables)
    }

    /// Look up definitions for `word`
    ///
    /// - Parameter word: `String`
    private func lookUp(word: String) {
        LookUp.entries(for: word) { [weak self] result in
            guard word == self?.searchText else { return } // Outdated
            self?.isLoading = false
            self?.result = result
        }
    }

    /// Publisher of `$searchText`
    private var searchTextPublisher: AnyPublisher<String, Never> {
        $searchText
            .dropFirst()
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - LookUpViewModelError

/// Error with `LookUpViewModel`
enum LookUpViewModelError: Error {

    /// No text to search
    case emptyText
}

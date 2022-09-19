//
//  LookUpViewModel.swift
//  Define
//
//  Created by Ben Shutt on 19/09/2022.
//

import Foundation
import SwiftUI

/// View model wrapper of the `LookUp` API
class LookUpViewModel: ObservableObject {

    /// Definitions of word
    @Published var definitions: [String] = []

    /// Is API loading
    @Published var isLoading = false

    /// Look up definitions for `word`
    ///
    /// - Parameter word: `String`
    func lookUp(word: String) {
        isLoading = true

        LookUp.entries(for: word) { [weak self] result in
            self?.isLoading = false

            let results = result.success?.results ?? []
            let definitions = results
                .flatMap { $0.lexicalEntries }
                .flatMap { $0.entries }
                .flatMap { $0.senses }
                .flatMap { $0.definitions }

            self?.definitions = definitions
        }
    }
}

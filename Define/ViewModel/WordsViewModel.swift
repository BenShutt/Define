//
//  WordsViewModel.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import SwiftUI

/// View model of the words database
final class WordsViewModel: ObservableObject {

    /// `Word` models to persist
    @AppStorage("words") var words: [Word] = []
}

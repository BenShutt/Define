//
//  String+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 01/01/2023.
//

import Foundation

public extension String {

    /// Trimming whitespaces and new lines
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Returns `nil` if `isEmpty` otherwise `self
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }

    /// Returns a new string with only the first character uppercased.
    /// This is different to `.capitalized` which also lowercases the other characters.
    var uppercasedFirstCharacter: String {
        guard let first else { return self }
        return first.uppercased() + dropFirst(1)
    }
}

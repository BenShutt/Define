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
}

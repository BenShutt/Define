//
//  Validated.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 06/10/2023.
//  Copyright © 2023 Ben Shutt. All rights reserved.
//

import Foundation

/// A model that is validated
///
/// # Enhancement
/// Could be a @propertyWrapper. Verbosity comes from optional and array types.
public protocol Validated {

    /// Validate the model, throwing on invalid
    mutating func validate() throws
}

// MARK: - String + Validated

extension String: Validated {

    /// Trim and throw if the trimmed value is empty
    public mutating func validate() throws {
        let value = trimmed.nilIfEmpty
        guard let value else { throw ValidationError.whitespaceAndNewlines }
        self = value
    }
}

// MARK: - Array + Validation

extension Array: Validated where Element: Validated {

    public mutating func validate() throws {
        for i in indices {
            try self[i].validate()
        }
    }
}

// MARK: - ValidationError

/// An error when validating
public enum ValidationError: Error {

    /// Trimming the string was unexpectedly empty
    case whitespaceAndNewlines
}

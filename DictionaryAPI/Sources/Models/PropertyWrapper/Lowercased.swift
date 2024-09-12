//
//  Lowercased.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 12/09/2024.
//

import Foundation

@propertyWrapper
public struct Lowercased: Model, Trimmable, CodablePropertyWrapper {
    public let wrappedValue: String

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.lowercased()
    }

    public func trim() -> Lowercased {
        .init(wrappedValue: wrappedValue.trim())
    }

    public var isEmpty: Bool {
        wrappedValue.isEmpty
    }
}

//
//  CodablePropertyWrapper.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 12/09/2024.
//

import Foundation

/// A property wrapper than should be encoded and decoded by its wrapped value
public protocol CodablePropertyWrapper: Codable {
    associatedtype Value: Codable
    var wrappedValue: Value { get }
    init(wrappedValue: Value)
}

public extension CodablePropertyWrapper {
    init(from decoder: any Decoder) throws {
        let value = try Value(from: decoder)
        self.init(wrappedValue: value)
    }

    func encode(to encoder: any Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

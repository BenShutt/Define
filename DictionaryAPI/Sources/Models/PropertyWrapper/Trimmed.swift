//
//  Trimmed.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 11/09/2024.
//

import Utilities

@propertyWrapper
public struct Trimmed<Value: Trimmable>: Model, CodablePropertyWrapper {
    public let wrappedValue: Value

    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue.trim()
    }

    public init(from decoder: any Decoder) throws {
        let value = try Value(from: decoder)
        self.init(wrappedValue: value)
        if wrappedValue.isEmpty {
            throw TrimmedError.trimmed
        }
    }
}

// MARK: - Trimmable

public protocol Trimmable: Model {
    func trim() -> Self

    var isEmpty: Bool { get }
}

extension String: Trimmable {
    public func trim() -> Self {
        trimmed
    }
}

extension Optional: Trimmable where Wrapped: Trimmable {
    public func trim() -> Self {
        switch self {
        case let .some(wrapped): wrapped.trim()
        case .none: nil
        }
    }

    public var isEmpty: Bool {
        switch self {
        case let .some(wrapped): wrapped.isEmpty
        case .none: false
        }
    }
}

// MARK: - TrimmedError

/// An error when trimming
public enum TrimmedError: Error {

    /// The trimmed string was unexpectedly empty
    case trimmed
}

// MARK: - KeyedDecodingContainer + Trimmed

// https://forums.swift.org/t/using-property-wrappers-with-codable/29804/12
// Also, must be public to work outside of this package
public extension KeyedDecodingContainer {
    func decode<T: Trimmable>(
        _ type: Trimmed<T?>.Type,
        forKey key: Self.Key
    ) throws -> Trimmed<T?> {
        try decodeIfPresent(type, forKey: key) ?? .init(wrappedValue: nil)
    }
}

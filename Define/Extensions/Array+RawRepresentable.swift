//
//  Array+RawRepresentable.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import Foundation

/// # Source:
/// https://nilcoalescing.com/blog/SaveCustomCodableTypesInAppStorageOrSceneStorage/
extension Array: RawRepresentable where Element: Codable {

    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode(Self.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard
            let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

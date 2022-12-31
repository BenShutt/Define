//
//  Result+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 31/12/2022.
//

import Foundation

extension Result {

    /// Returns the associated value if the result is a success, `nil` otherwise.
    var success: Success? {
        guard case let .success(value) = self else { return nil }
        return value
    }
}

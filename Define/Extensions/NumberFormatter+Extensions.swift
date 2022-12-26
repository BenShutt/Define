//
//  NumberFormatter+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 26/12/2022.
//

import Foundation

extension NumberFormatter {

    /// `string(from:)` with `number`
    /// - Parameter value: `Double`
    /// - Returns: `String`
    func numberString(from value: Double) -> String {
        string(from: value as NSNumber) ?? "\(value)"
    }
}

//
//  Decimal+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2024.
//

import Foundation

extension Decimal {

    /// Round this decimal with the given scale and rounding mode
    ///
    /// # References
    /// https://stackoverflow.com/a/68821419/5024990
    ///
    /// - Parameters:
    ///   - scale: Rounding scale
    ///   - roundingMode: Rounding mode
    /// - Returns: A new rounded decimal
    func rounded(
        scale: Int = 0,
        roundingMode: NSDecimalNumber.RoundingMode = .plain
    ) -> Decimal {
        var number = self
        var result = Decimal()
        NSDecimalRound(&result, &number, scale, roundingMode)
        return result
    }
}

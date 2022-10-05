//
//  AppIconSize.swift
//  Define
//
//  Created by Ben Shutt on 05/10/2022.
//

import Foundation

/// Set of app icon sizes
struct AppIconSize: Equatable, Hashable, Codable {

    /// Set of `AppIconSize`s to generate
    static var all: [AppIconSize] {
        [
            .init(size: 20, multipliers: [1, 2, 3]),
            .init(size: 29, multipliers: [1, 2, 3]),
            .init(size: 40, multipliers: [1, 2, 3]),
            .init(size: 60, multipliers: [2, 3]),
            .init(size: 76, multipliers: [1, 2]),
            .init(size: 83.5, multipliers: [2]),
            .init(size: 1024, multipliers: [1])
        ]
    }

    /// Size in pts
    var size: CGFloat

    /// Size multipers to apply
    var multipliers: [Int]

    /// Size in pixels (px)
    ///
    /// - Parameter multiplier: `Int`
    /// - Returns: `CGFloat`
    func sizePx(for multiplier: Int) -> CGFloat {
        size * CGFloat(multiplier)
    }

    /// Format `size` as `String`
    var sizeString: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter.string(from: size as NSNumber) ?? "\(size)"
    }

    /// Map to file name for `multiplier`
    ///
    /// - Parameters:
    ///   - multiplier: `Int`
    ///   - extn: `String` file extension (not including full-stop)
    /// - Returns: `String`
    func fileName(for multiplier: Int, extn: String) -> String {
        var fileName = "appIcon-\(sizeString)"
        if multiplier > 1 {
            fileName += "@\(multiplier)x"
        }
        return "\(fileName).\(extn)"
    }
}

//
//  AppIconSize.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 05/10/2022.
//

import Foundation

/// Set of app icon sizes
struct AppIconSize: Equatable, Hashable, Codable, Comparable, CustomStringConvertible {

    /// Set of `AppIconSize`s to generate
    static let all: [AppIconSize] = [
        // 20px
        .init(size: 20, multiplier: 1),
        .init(size: 20, multiplier: 2),
        .init(size: 20, multiplier: 3),

        // 29px
        .init(size: 29, multiplier: 1),
        .init(size: 29, multiplier: 2),
        .init(size: 29, multiplier: 3),

        // 40px
        .init(size: 40, multiplier: 1),
        .init(size: 40, multiplier: 2),
        .init(size: 40, multiplier: 3),

        // 60px
        .init(size: 60, multiplier: 2),
        .init(size: 60, multiplier: 3),

        // 76px
        .init(size: 76, multiplier: 1),
        .init(size: 76, multiplier: 2),

        // 83.5px
        .init(size: 83.5, multiplier: 2),

        // 1024px
        .init(size: 1024, multiplier: 1)
    ]

    /// Get the max `AppIconSize`
    static var max: AppIconSize {
        AppIconSize.all.max()! // Rare scenario where force unwrap is OK
    }

    /// Size of the image
    private let size: CGFloat

    /// Size multiplier to apply
    private let multiplier: Int

    /// Multiplied size
    var multipliedSize: CGFloat {
        size * CGFloat(multiplier)
    }

    /// Multiplied `CGSize`
    var multipliedCGSize: CGSize {
        CGSize(width: multipliedSize, height: multipliedSize)
    }

    /// Format `size` as `String`
    var sizeString: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter.string(from: size as NSNumber) ?? "\(size)"
    }

    /// Name of the image file
    ///
    /// - Note:
    /// Does not include file extension
    var fileName: String {
        let prefix = "appIcon-\(sizeString)"
        let suffix = multiplier > 1 ? "@\(multiplier)x" : ""
        return "\(prefix)\(suffix)"
    }

    // MARK: - Comparable

    static func < (lhs: AppIconSize, rhs: AppIconSize) -> Bool {
        lhs.multipliedSize < rhs.multipliedSize
    }

    // MARK: - CustomStringConvertible

    var description: String {
        fileName
    }
}

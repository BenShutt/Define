//
//  CGFloat+Values.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// Set of fixed `CGFloat` values
extension CGFloat {
    static let π: CGFloat = .pi

    // MARK: - Config

    static let borderWidth: CGFloat = 3
    static let iconSize: CGFloat = 20

    // MARK: - Size

    static let small: CGFloat = 5
    static let medium: CGFloat = 10
    static let mediumLarge: CGFloat = 15
    static let large: CGFloat = 20

    // MARK: - Dimension

    static let hMargin: CGFloat = .large
    static let vMargin: CGFloat = .medium
}

// MARK: - Double + Values

extension Double {
    static let π: Double = .pi
}

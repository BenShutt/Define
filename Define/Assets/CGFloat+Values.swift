//
//  CGFloat+Values.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// Set of fixed `CGFloat` values
extension CGFloat {

    /// π
    static let π: CGFloat = .pi

    // MARK: - Config

    /// 1.5pts
    static let borderWidth: CGFloat = 1.5

    /// 22pts
    static let icon: CGFloat = 22

    /// 34pts
    static let iconLarge: CGFloat = 34

    /// 10pts
    static let cornerRadius: CGFloat = 10

    /// 44pts - minimum accessible touch area required
    static let minTouchArea: CGFloat = 44

    // MARK: - Size

    /// 2pts
    static let extraSmall: CGFloat = 2

    /// 5pts
    static let small: CGFloat = 5

    /// 7.5pts
    static let smallMedium: CGFloat = 7.5

    /// 15pts
    static let medium: CGFloat = 15

    /// 17.5pts
    static let mediumLarge: CGFloat = 17.5

    /// 20pts
    static let large: CGFloat = 20

    /// 25pts
    static let extraLarge: CGFloat = 25

    // MARK: - Dimension

    /// Large pts
    static let hMargin: CGFloat = .large

    /// Medium pts
    static let vMargin: CGFloat = .medium
}

// MARK: - Double + Values

extension Double {

    /// π
    static let π: Double = .pi
}

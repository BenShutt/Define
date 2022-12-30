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

    /// 20pts
    static let iconSize: CGFloat = 20

    /// 2pts
    static let shadowRadius: CGFloat = 2

    /// 6pts
    static let cornerRadius: CGFloat = 6

    // MARK: - Size

    /// 5pts
    static let small: CGFloat = 5

    /// 7.5pts
    static let smallMedium: CGFloat = 7.5

    /// 10pts
    static let medium: CGFloat = 10

    /// 15pts
    static let mediumLarge: CGFloat = 15

    /// 20pts
    static let large: CGFloat = 20

    /// 25pts
    static let extraLarge: CGFloat = 25

    // MARK: - Dimension

    /// Large pts
    static let hMargin: CGFloat = .large

    /// Medium pts
    static let vMargin: CGFloat = .medium

    // MARK: - Launch

    struct Launch {
        static let containerSize: CGFloat = 200
        static let padding: CGFloat = 40
    }
}

// MARK: - Double + Values

extension Double {

    static let π: Double = .pi
}

// MARK: - TimeInterval + Values

extension TimeInterval {

    static let debounce: TimeInterval = 1
    static let accordion: TimeInterval = 0.1
}

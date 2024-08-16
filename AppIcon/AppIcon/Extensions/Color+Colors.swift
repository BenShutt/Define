//
//  Color+Colors.swift
//  AppIcon
//
//  Created by Ben Shutt on 29/09/2023.
//

import SwiftUI
import ColorUtilities

public extension Color {
    static let appIconWhite = Color(white: 1)
    static let appIconBlue = Color(red255: 52, green: 152, blue: 219)
    static let appIconDarkGray = Color(white255: 12)

    // MARK: - Computed

    static let appIconDefault: Color = .appIconBlue
    static let appIconShadowHeavy: Color = .appIconDarkGray.opacity(0.05)
    static let appIconShadowLight: Color = .appIconDarkGray.opacity(0.025)
}

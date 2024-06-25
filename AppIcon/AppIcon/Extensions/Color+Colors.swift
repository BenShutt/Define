//
//  Color+Colors.swift
//  AppIcon
//
//  Created by Ben Shutt on 29/09/2023.
//

import SwiftUI

public extension Color {
    static let appIconWhite = Color(white: 1)
    static let appIconBlue = Color(red: 52 / 255, green: 152 / 255, blue: 219 / 255)
    static let appIconDarkGray = Color(white: 12 / 255)

    // MARK: - Computed

    static let appIconDefault: Color = .appIconBlue
    static let appIconShadowHeavy: Color = .appIconDarkGray.opacity(0.1)
}

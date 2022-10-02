//
//  CustomFont.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import SwiftUI

/// A custom font
protocol CustomFont {

    /// Name of the font
    var fontName: String { get }
}

// MARK: - View + CustomFont

extension View {

    /// Apply a custom `font` with the given `size`
    /// - Parameters:
    ///   - font: `Font`
    ///   - size: `CGFloat`
    /// - Returns: `View`
    func customFont<Font: CustomFont>(_ font: Font, size: CGFloat) -> some View {
        self.font(.custom(font.fontName, size: size))
    }
}

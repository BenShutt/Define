//
//  TextStyle.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// Set of `TextStyle`s (styles of text)
enum TextStyle: String, CaseIterable, Hashable, Identifiable {
    case h1
    case h2
    case h3
    case h4
    case body
    case button
    case tag
    case caption

    var id: Self { self }

    /// Get size of the font
    private var fontSize: CGFloat {
        switch self {
        case .h1: 26
        case .h2: 20
        case .h3: 18
        case .h4: 16
        case .body: 16
        case .button: 16
        case .tag: 14
        case .caption: 14
        }
    }

    /// Get name and weight of the font
    private var font: WorkSans {
        switch self {
        case .h1: .bold
        case .h2: .semiBold
        case .h3: .semiBold
        case .h4: .semiBold
        case .body: .regular
        case .button: .bold
        case .tag: .semiBold
        case .caption: .lightItalic // Italic applied via font
        }
    }

    /// Default text color
    private var defaultTextColor: Color {
        switch self {
        case .h1: .appDarkGray
        case .h2: .appDarkGray
        case .h3: .appDarkGray
        case .h4: .appDarkGray
        case .body: .appGray
        case .button: .appDarkGray
        case .tag: .appGray
        case .caption: .appGray
        }
    }

    /// Map to `UIFont`
    var uiFont: UIFont? {
        UIFont(name: font.rawValue, size: fontSize)
    }

    /// Make a styled text
    /// - Parameters:
    ///   - lineLimit: Number of lines to limit to, defaults to `nil`
    ///   - textColor: Override text color, defaults to text style's default
    ///   - fill: Fill parent width and set text alignment, defaults to `nil`
    /// - Returns: A styled text
    func styledText(
        lineLimit: Int?,
        textColor: Color?,
        fill: TextAlignment?
    ) -> StyledText {
        StyledText(
            font: font,
            fontSize: fontSize,
            lintLimit: lineLimit,
            foregroundColor: textColor ?? defaultTextColor,
            maxWidth: fill != nil ? .infinity : nil,
            textAlignment: fill ?? .center
        )
    }
}

// MARK: - View + TextStyle

extension View {
    func textStyle(
        _ textStyle: TextStyle,
        lineLimit: Int? = nil,
        textColor: Color? = nil,
        fill: TextAlignment? = nil
    ) -> some View {
        modifier(textStyle.styledText(
            lineLimit: lineLimit,
            textColor: textColor,
            fill: fill
        ))
    }
}

// MARK: - Preview

#Preview {
    VStack(alignment: .leading, spacing: .medium) {
        ForEach(TextStyle.allCases) { textStyle in
            Text(verbatim: "Preview: " + textStyle.rawValue)
                .textStyle(textStyle)
        }
    }
}

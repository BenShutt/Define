//
//  TextStyle.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI
import Utilities

/// Set of styles of text
enum TextStyle: String, CaseIterable, Identifiable {
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
    private var notoSans: NotoSans {
        switch self {
        case .h1: .black
        case .h2: .black
        case .h3: .extraBold
        case .h4: .bold
        case .body: .regular
        case .button: .extraBold
        case .tag: .semiBold
        case .caption: .lightItalic // Italic applied via font
        }
    }

    /// Default text color
    var defaultTextColor: Color {
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

    /// Map to font
    var font: Font {
        .custom(notoSans.rawValue, size: fontSize)
    }

    /// Map to UI font
    var uiFont: UIFont {
        let font = UIFont(name: notoSans.rawValue, size: fontSize)
        guard let font else { fatalError("\(UIFont.self)") }
        return font
    }
}

// MARK: - View + TextStyle

extension View {
    func textStyle(
        _ textStyle: TextStyle,
        lineLimit: Int? = nil,
        fill: TextAlignment? = nil
    ) -> some View {
        self.styledText(
            font: textStyle.font,
            lineLimit: lineLimit,
            textAlignment: fill ?? .center,
            foregroundColor: textStyle.defaultTextColor,
            maxWidth: fill != nil ? .infinity : nil
        )
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

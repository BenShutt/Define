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
    case body
    case button
    case tag
    case caption

    /// Identifier
    var id: Self { self }

    /// Get size of the font
    var fontSize: CGFloat {
        switch self {
        case .h1: return 32
        case .h2: return 20
        case .h3: return 16
        case .body: return 16
        case .button: return 16
        case .tag: return 12
        case .caption: return 12
        }
    }

    /// Get name and weight of the font
    var font: WorkSans {
        switch self {
        case .h1: return .bold
        case .h2: return .bold
        case .h3: return .bold
        case .body: return .regular
        case .button: return .semiBold
        case .tag: return .semiBold
        case .caption: return .light
        }
    }
}

// MARK: - View + TextStyle

extension View {

    /// Apply `textStyle`
    /// 
    /// - Parameter textStyle: `TextStyle`
    /// - Returns: `View`
    func textStyle(_ textStyle: TextStyle) -> some View {
        customFont(textStyle.font, size: textStyle.fontSize)
    }

    /// Standard `.h1` implementation
    func h1() -> some View {
        textStyle(.h1)
            .foregroundColor(.appBlack)
    }

    /// Standard `.h2` implementation
    func h2() -> some View {
        textStyle(.h2)
            .foregroundColor(.appBlack)
    }

    /// Standard `.h3` implementation
    func h3() -> some View {
        textStyle(.h3)
            .foregroundColor(.appBlack)
    }

    /// Standard `.body` implementation
    func body() -> some View {
        textStyle(.body)
            .foregroundColor(.appDarkGray)
    }

    /// Standard `.tag` implementation
    func tag() -> some View {
        textStyle(.tag)
            .foregroundColor(Color.appDarkGray)
    }

    /// Standard `.caption` implementation
    func caption() -> some View {
        textStyle(.caption)
            .foregroundColor(Color.appDarkGray)
            .italic()
    }
}

// MARK: - PreviewProvider

struct TextStyle_Previews: PreviewProvider {

    static var previews: some View {
        VStack(alignment: .leading, spacing: .large) {
            ForEach(values: TextStyle.allCases) { textStyle in
                Text(verbatim: "Text Preview (\(textStyle))")
                    .textStyle(textStyle)
                    .foregroundColor(.appBlack)
            }
        }
    }
}

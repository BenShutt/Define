//
//  TextStyle.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// Set of `TextStyle`s (styles of text)
enum TextStyle {

    case h1
    case h2
    case body
    case button
    case tag

    /// Get size of the font
    var fontSize: CGFloat {
        switch self {
        case .h1: return 32
        case .h2: return 20
        case .body: return 16
        case .button: return 16
        case .tag: return 12
        }
    }

    /// Get name and weight of the font
    var font: WorkSans {
        switch self {
        case .h1: return .bold
        case .h2: return .bold
        case .body: return .regular
        case .button: return .semiBold
        case .tag: return .semiBold
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

    /// Standard `.body` implementation
    func body() -> some View {
        textStyle(.body)
            .foregroundColor(.appDarkGray)
    }
}

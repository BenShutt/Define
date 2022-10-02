//
//  TextStyle.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// Set of `TextStyle`s (styles of text)
enum TextStyle {
    case title
    case body
    case button

    /// Get size of the font
    var fontSize: CGFloat {
        switch self {
        case .title: return 24
        case .body: return 16
        case .button: return 16
        }
    }

    /// Get weight of the font
    var fontWeight: Font.Weight {
        switch self {
        case .title: return .bold
        case .body: return .regular
        case .button: return .semibold
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
        self.font(.system(size: textStyle.fontSize, weight: textStyle.fontWeight))
    }
}

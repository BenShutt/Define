//
//  TextStyle.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// Set of `TextStyle`s (styles of text)
enum TextStyle {
    case body

    /// Get size of the font
    var fontSize: CGFloat {
        switch self {
        case .body: return 16
        }
    }

    /// Get weight of the font
    var fontWeight: Font.Weight {
        switch self {
        case .body: return .regular
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

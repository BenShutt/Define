//
//  WorkSans.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import SwiftUI

/// WordSans custom font caes
enum WorkSans: String {
    case black = "WorkSans-Black"
    case blackItalic = "WorkSans-BlackItalic"
    case bold = "WorkSans-Bold"
    case boldItalic = "WorkSans-BoldItalic"
    case extraBold = "WorkSans-ExtraBold"
    case extraBoldItalic = "WorkSans-ExtraBoldItalic"
    case extraLight = "WorkSans-ExtraLight"
    case extraLightItalic = "WorkSans-ExtraLightItalic"
    case italic = "WorkSans-Italic"
    case light = "WorkSans-Light"
    case lightItalic = "WorkSans-LightItalic"
    case medium = "WorkSans-Medium"
    case mediumItalic = "WorkSans-MediumItalic"
    case regular = "WorkSans-Regular"
    case semiBold = "WorkSans-SemiBold"
    case semiBoldItalic = "WorkSans-SemiBoldItalic"
    case thin = "WorkSans-Thin"
    case thinItalic = "WorkSans-ThinItalic"
}

// MARK: - View + WorkSans

extension View {

    /// Apply a custom `workSans` font with the given `size`
    /// - Parameters:
    ///   - workSans: `WorkSans` case of font
    ///   - size: `CGFloat` size of font
    /// - Returns: Modified `View`
    func workSans(_ workSans: WorkSans, size: CGFloat) -> some View {
        font(.custom(workSans.rawValue, size: size))
    }
}

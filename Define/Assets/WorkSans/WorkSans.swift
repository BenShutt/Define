//
//  WorkSans.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import Foundation

/// WordSans custom font caes
enum WorkSans: String, CustomFont {

    case black
    case blackItalic
    case bold
    case boldItalic
    case extraBold
    case extraBoldItalic
    case extraLight
    case extraLightItalic
    case italic
    case light
    case lightItalic
    case medium
    case mediumItalic
    case regular
    case semiBold
    case semiBoldItalic
    case thin
    case thinItalic

    var fontName: String {
        "WorkSans-\(rawValue.capitalized)"
    }
}

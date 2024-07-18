//
//  View+SystemImage.swift
//  AppIcon
//
//  Created by Ben Shutt on 25/06/2024.
//

import SwiftUI

public extension View {

    /// Setting the size of system images is often done with fonts.
    /// This method provides a shorthand with a defaulted weight.
    /// It also improves readability.
    /// - Parameters:
    ///   - size: Size of the font
    ///   - weight: Weight of the font, defaults to `.regular`
    /// - Returns: A modified view
    func systemImage(
        size: CGFloat,
        weight: Font.Weight = .regular
    ) -> some View {
        font(.system(size: size, weight: weight))
    }
}

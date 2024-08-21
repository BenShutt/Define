//
//  CGSize+Extensions.swift
//  AppIcon
//
//  Created by Ben Shutt on 23/06/2024.
//

import SwiftUI

public extension CGSize {

    /// Returns the minimum of the `width` and the `height`
    var min: CGFloat { Swift.min(width, height) }
    
    /// Adds the horizontal components to the width and vertical
    /// components to the height
    /// - Parameter insets: Amount of padding to add
    /// - Returns: The new size with padding
    func padding(_ insets: EdgeInsets) -> CGSize {
        CGSize(
            width: width + insets.horizontal,
            height: height + insets.vertical
        )
    }
}

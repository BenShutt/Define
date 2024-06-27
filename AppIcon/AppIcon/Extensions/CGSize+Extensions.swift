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
}

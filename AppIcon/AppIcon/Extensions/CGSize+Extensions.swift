//
//  CGSize+Extensions.swift
//  AppIcon
//
//  Created by Ben Shutt on 23/06/2024.
//

import SwiftUI

public extension CGSize {
    var min: CGFloat { Swift.min(width, height) }
}

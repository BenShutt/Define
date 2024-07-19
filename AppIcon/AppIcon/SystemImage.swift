//
//  SystemImage.swift
//  AppIcon
//
//  Created by Ben Shutt on 18/07/2024.
//  Copyright © 2024 Ben Shutt. All rights reserved.
//

import SwiftUI

public enum SystemImage: String {
    case magnifyingGlass = "magnifyingglass"
    case chevronRight = "chevron.right"
    case chevronUp = "chevron.up"
    case chevronDown = "chevron.down"
    case plus
    case trash
    case crossCircleFill = "xmark.circle.fill"
    case checkmark
    case clock
    case arrow = "arrow.forward"
}

// MARK: - Image + SystemImage

public extension Image {
    init(_ image: SystemImage) {
        self.init(systemName: image.rawValue)
    }
}

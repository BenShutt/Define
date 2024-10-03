//
//  SystemImage.swift
//  AppIcon
//
//  Created by Ben Shutt on 18/07/2024.
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
    case arrowBack = "arrow.backward"
    case paste = "doc.on.doc.fill"
}

// MARK: - Image + SystemImage

public extension Image {
    init(_ image: SystemImage) {
        self.init(systemName: image.rawValue)
    }
}

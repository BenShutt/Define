//
//  SystemImage.swift
//  AppIcon
//
//  Created by Ben Shutt on 18/07/2024.
//  Copyright © 2024 Ben Shutt. All rights reserved.
//

import SwiftUI

// TODO: Use!

public enum SystemImage: String {
    case magnifyingGlass = "magnifyingglass"
}

// MARK: - Image + SystemImage

public extension Image {
    init(_ image: SystemImage) {
        self.init(systemName: image.rawValue)
    }
}

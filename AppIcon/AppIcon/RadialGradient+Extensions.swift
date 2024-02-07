//
//  RadialGradient+Extensions.swift
//  AppIcon
//
//  Created by Ben Shutt on 30/10/2023.
//

import SwiftUI

public extension RadialGradient {

    static func make(
        color: Color = .appIconBlue,
        startRadius: CGFloat,
        endRadius: CGFloat
    ) -> RadialGradient {
        RadialGradient(
            colors: [
                color.opacity(0.05),
                color.opacity(1)
            ],
            center: .center,
            startRadius: startRadius,
            endRadius: endRadius
        )
    }
}

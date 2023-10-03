//
//  LinearGradient+Gradients.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

extension LinearGradient {

    static func header(color: Color) -> LinearGradient {
        LinearGradient(
            colors: [
                .appWhite,
                color.opacity(0.2)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    static let button = LinearGradient(
        colors: [
            Color.appYellow,
            Color.appMaize,
            Color.appYellow
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

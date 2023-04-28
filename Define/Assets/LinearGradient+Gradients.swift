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
}

extension RadialGradient {

    static let button = RadialGradient(
        colors: [
            Color.appMaize,
            Color.appYellow
        ],
        center: .center,
        startRadius: 0,
        endRadius: 2 * .π
    )
}

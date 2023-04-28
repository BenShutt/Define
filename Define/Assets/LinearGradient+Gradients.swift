//
//  LinearGradient+Gradients.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

extension LinearGradient {

    static let header = LinearGradient(
        colors: [
            .appWhite,
            .appBlue
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
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

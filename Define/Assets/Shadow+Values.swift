//
//  Shadow+Values.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

// MARK: Shadow

struct Shadow {

    var color: Color
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat
}

// MARK: Shadow + Values

extension Shadow {

    static let sticky = Shadow(
        color: .appDarkGray.opacity(0.05),
        radius: 15,
        x: 0,
        y: 2
    )

    static let container = Shadow(
        color: .appLightGray.opacity(0.08),
        radius: 10,
        x: 0,
        y: 2
    )
}

// MARK: View + Shadow

extension View {

    func shadow(_ shadow: Shadow) -> some View {
        self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
}

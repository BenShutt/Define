//
//  Shadow+Values.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI
import CubeFoundationSwiftUI

// MARK: FigmaShadow + Values

extension FigmaShadow {

    static let sticky = FigmaShadow(
        x: 0,
        y: 2,
        blur: 15 * 2,
        color: .appDarkGray.opacity(0.05)
    )

    static let container = FigmaShadow(
        x: 0,
        y: 2,
        blur: 10 * 2,
        color: .appLightGray.opacity(0.08)
    )
}

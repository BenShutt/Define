//
//  FigmaShadow+Values.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI
import CubeFoundationSwiftUI

extension FigmaShadow {
    static let sticky = FigmaShadow(
        x: 0,
        y: 2,
        blur: 15 * 2,
        color: .shadowHeavy
    )

    static let container = FigmaShadow(
        x: 0,
        y: 0,
        blur: 3 * 2,
        color: .shadowLight
    )
}

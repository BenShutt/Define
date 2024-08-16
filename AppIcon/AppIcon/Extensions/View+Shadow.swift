//
//  View+Shadow.swift
//  AppIcon
//
//  Created by Ben Shutt on 19/07/2024.
//

import SwiftUI

public extension View {
    func stickyShadow() -> some View {
        compositingGroup()
            .shadow(color: .appIconShadowHeavy, radius: 10, x: 0, y: 2)
    }

    func containerShadow() -> some View {
        compositingGroup()
            .shadow(color: .appIconShadowLight, radius: 7.5, x: 0, y: 0)
    }
}

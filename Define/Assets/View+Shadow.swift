//
//  View+Shadow.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

extension View {
    func stickyShadow() -> some View {
        compositingGroup()
            .shadow(color: .shadowHeavy, radius: 15, x: 0, y: 2)
    }

    func containerShadow() -> some View {
        compositingGroup()
            .shadow(color: .shadowLight, radius: 3, x: 0, y: 0)
    }
}

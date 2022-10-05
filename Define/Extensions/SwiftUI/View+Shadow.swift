//
//  View+Shadow.swift
//  Define
//
//  Created by Ben Shutt on 05/10/2022.
//

import SwiftUI

extension View {

    func appShadow() -> some View {
        self.shadow(color: .appShadow, radius: .shadowRadius, x: 0, y: 0)
    }
}

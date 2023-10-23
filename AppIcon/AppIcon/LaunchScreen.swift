//
//  LaunchScreen.swift
//  AppIcon
//
//  Created by Ben Shutt on 03/10/2023.
//

import SwiftUI

public struct LaunchScreen: View {

    /// Public member-wise initializer
    public init() {}

    public var body: some View {
        ZStack {
            AppIconGradient(end: 1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            AppIcon(
                size: 150,
                color: .appIconBlue,
                isContainer: true
            )
        }
    }
}

// MARK: - Preview

#Preview {
    LaunchScreen()
}

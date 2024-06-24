//
//  LaunchScreen.swift
//  AppIcon
//
//  Created by Ben Shutt on 03/10/2023.
//

import SwiftUI

public struct LaunchScreen: View {
    @State private var appIconSize: CGFloat = 0
    public var color: Color

    public init(color: Color = .appIconBlue) {
        self.color = color
    }

    public var body: some View {
        AppIconGradient(end: 1)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .onSizeChanged { appIconSize = $0.min * 0.4 }
            .overlay {
                AppIcon(color: color)
                    .frame(width: appIconSize, height: appIconSize)
                    .appIconContainer(color: color)
            }
    }
}

// MARK: - Preview

#Preview {
    LaunchScreen()
}

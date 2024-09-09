//
//  AppIcon.swift
//  AppIcon
//
//  Created by Ben Shutt on 29/09/2023.
//

import SwiftUI
import Utilities

public struct AppIcon: View {
    @State private var size: CGFloat = 0
    public var color: Color
    public var animationValue: Int

    public init(
        color: Color = .appIconDefault,
        animationValue: Int = 0
    ) {
        self.color = color
        self.animationValue = animationValue
    }

    public var body: some View {
        AppIconGradient(color: color)
            .onSizeChange { size = $0.min }
            .overlay {
                Image(.magnifyingGlass)
                    .systemImage(size: size * 0.6, weight: .heavy)
                    .foregroundStyle(Color.appIconDarkGray)
                    .symbolEffect(.bounce, value: animationValue)
                    .accessibilityHidden(true)
            }
    }
}

// MARK: - Preview

#Preview {
    AppIcon()
        .frame(width: 200, height: 200)
}

//
//  AppIcon.swift
//  AppIcon
//
//  Created by Ben Shutt on 29/09/2023.
//

import SwiftUI

public struct AppIcon: View {
    @State private var size: CGFloat = 0
    public var color: Color
    public var animationValue: Int

    public init(
        color: Color = .appIconBlue,
        animationValue: Int = 0
    ) {
        self.color = color
        self.animationValue = animationValue
    }

    public var body: some View {
        AppIconGradient(color: color)
            .onSizeChanged { size = $0.min }
            .overlay {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: size * 0.6, weight: .heavy))
                    .foregroundColor(Color.appIconDarkGray)
                    .bounceSymbol(animationValue)
            }
    }
}

extension AppIcon {
    static func make(size: CGFloat) -> some View {
        AppIcon()
            .frame(width: size, height: size)
    }
}

// MARK: - Preview

#Preview {
    AppIcon()
        .frame(width: 200, height: 200)
}

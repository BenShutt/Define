//
//  AppIconContainer.swift
//  AppIcon
//
//  Created by Ben Shutt on 23/06/2024.
//

import SwiftUI

private struct AppIconContainer: ViewModifier {
    @State private var size: CGFloat = 0
    var color: Color

    private var shape: some InsettableShape {
        RoundedRectangle(cornerRadius: size * 0.2)
    }

    func body(content: Content) -> some View {
        content
            .onSizeChange { size = $0.min }
            .clipShape(shape)
            .overlay {
                shape
                    .strokeBorder(lineWidth: size * 0.02)
                    .foregroundStyle(color.opacity(0.25))
            }
            .compositingGroup()
            .shadow(
                color: .appIconShadowHeavy,
                radius: size * 0.1
            )
    }
}

// MARK: - View + AppIconContainer

public extension View {
    func appIconContainer(color: Color = .appIconDefault) -> some View {
        modifier(AppIconContainer(color: color))
    }
}

// MARK: - Preview

#Preview {
    AppIcon()
        .frame(width: 300, height: 300)
        .appIconContainer()
}

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
            .onSizeChanged { size = $0.min }
            .clipShape(shape)
            .overlay {
                shape
                    .strokeBorder(lineWidth: 2)
                    .foregroundStyle(color.opacity(0.1))
            }
            .compositingGroup()
            .shadow(
                color: .appIconBlack.opacity(0.25),
                radius: size * 0.05
            )
    }
}

// MARK: - View + AppIconContainer

public extension View {
    func appIconContainer(color: Color) -> some View {
        modifier(AppIconContainer(color: color))
    }
}

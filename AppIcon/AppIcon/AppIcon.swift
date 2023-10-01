//
//  AppIcon.swift
//  AppIcon
//
//  Created by Ben Shutt on 29/09/2023.
//

import SwiftUI

public struct AppIcon: View {

    public var size: CGFloat
    public var color: Color
    public var isContainer: Bool

    public init(
        size: CGFloat,
        color: Color = .appIconBlue,
        isContainer: Bool = true
    ) {
        self.size = size
        self.color = color
        self.isContainer = isContainer
    }

    public var body: some View {
        ZStack {
            RadialGradient(
                colors: [
                    .appIconWhite,
                    color
                ],
                center: .center,
                startRadius: size * 0.15,
                endRadius: size * 0.9
            )

            Image(systemName: "magnifyingglass")
                .font(.system(size: size * 0.6, weight: .black))
                .foregroundColor(Color.appIconDarkGray)
        }
        .frame(width: size, height: size)
        .modifier(Container(
            size: size,
            isContainer: isContainer
        ))
    }
}

// MARK: - Container

private struct Container: ViewModifier {

    var size: CGFloat
    var isContainer: Bool

    func body(content: Content) -> some View {
        if isContainer {
            content
                .clipShape(RoundedRectangle(cornerRadius: size * 0.2))
                .shadow(color: .black.opacity(0.25), radius: size * 0.1)
        } else {
            content
        }
    }
}

// MARK: - Preview

#Preview {
    AppIcon(size: 200)
}

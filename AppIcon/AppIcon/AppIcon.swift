//
//  AppIcon.swift
//  AppIcon
//
//  Created by Ben Shutt on 29/09/2023.
//

import SwiftUI

public struct AppIcon: View {

    public var size: CGFloat
    public var isContainer: Bool

    public init(size: CGFloat, isContainer: Bool) {
        self.size = size
        self.isContainer = isContainer
    }

    public var body: some View {
        ZStack {
            LinearGradient(
                colors: [.appBlue, .appWhite, .appBlue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Image(systemName: "magnifyingglass")
                .font(.system(size: size * 0.6, weight: .black))
                .foregroundColor(Color.appDarkGray)
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
    AppIcon(size: 200, isContainer: true)
}

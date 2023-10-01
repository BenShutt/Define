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
    @Binding public var animationValue: Int

    public init(
        size: CGFloat,
        color: Color = .appIconBlue,
        isContainer: Bool = true,
        animationValue: Binding<Int> = .constant(0)
    ) {
        self.size = size
        self.color = color
        self.isContainer = isContainer
        _animationValue = animationValue
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
                .modifier(SymbolAnimator(value: $animationValue))
        }
        .background(Color.appIconWhite)
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
                .compositingGroup()
                .shadow(color: .appIconBlack.opacity(0.25), radius: size * 0.1)
        } else {
            content
        }
    }
}

// MARK: - SymbolAnimator

private struct SymbolAnimator<Value: Equatable>: ViewModifier {

    @Binding var value: Value

    func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content.symbolEffect(.bounce, value: value)
        } else {
            content
        }
    }
}

// MARK: - Preview

#Preview {
    AppIcon(size: 200)
}

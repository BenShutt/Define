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
            AppIconGradient(color: color)

            Image(systemName: "magnifyingglass")
                .font(.system(size: size * 0.6, weight: .bold))
                .foregroundColor(Color.appIconDarkGray)
                .modifier(SymbolAnimator(value: $animationValue))
        }
        .frame(width: size, height: size)
        .modifier(Container(
            color: color,
            size: size,
            isContainer: isContainer
        ))
    }
}

// MARK: - Container

private struct Container: ViewModifier {

    var color: Color
    var size: CGFloat
    var isContainer: Bool

    private var shape: some InsettableShape {
        RoundedRectangle(cornerRadius: size * 0.2)
    }

    func body(content: Content) -> some View {
        if isContainer {
            content
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
        } else {
            content
        }
    }
}

// MARK: - SymbolAnimator

private struct SymbolAnimator<Value: Equatable>: ViewModifier {

    @Binding var value: Value

    func body(content: Content) -> some View {
        if #available(iOS 17, macOS 14, *) {
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

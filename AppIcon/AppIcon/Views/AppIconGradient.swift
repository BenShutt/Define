//
//  AppIconGradient.swift
//  AppIcon
//
//  Created by Ben Shutt on 03/10/2023.
//

import SwiftUI

public struct AppIconGradient: View {
    public var color: Color
    public var start: CGFloat
    public var end: CGFloat

    public init(
        color: Color = .appIconDefault,
        start: CGFloat = 0.25,
        end: CGFloat = 0.75
    ) {
        self.color = color
        self.start = start
        self.end = end
    }

    public var body: some View {
        GeometryReader { metrics in
            RadialGradient(
                colors: [
                    color.opacity(0.05),
                    color.opacity(1)
                ],
                center: .center,
                startRadius: metrics.size.min * start,
                endRadius: metrics.size.min * end
            )
            .background(Color.appIconWhite)
        }
    }
}

// MARK: - Preview

#Preview {
    AppIconGradient()
        .frame(width: 300, height: 300)
}

//
//  AppIconGradient.swift
//  AppIcon
//
//  Created by Ben Shutt on 03/10/2023.
//

import SwiftUI

struct AppIconGradient: View {

    var color: Color = .appIconBlue
    var start: CGFloat = 0.25
    var end: CGFloat = 0.75

    var body: some View {
        GeometryReader { metrics in
            RadialGradient(
                colors: [
                    color.opacity(0.05),
                    color.opacity(0.25)
                ],
                center: .center,
                startRadius: metrics.size.width * start,
                endRadius: metrics.size.width * end
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

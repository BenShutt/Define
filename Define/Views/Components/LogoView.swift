//
//  LogoView.swift
//  Define
//
//  Created by Ben Shutt on 05/10/2022.
//

import SwiftUI

/// View drawing the app logo
struct LogoView: View {

    /// Render border and shadow
    var showBorder = true

    /// Corner radius of border relative to container size
    /// - Parameter proxy: `GeometryProxy`
    /// - Returns: `CGFloat`
    func borderRadius(_ proxy: GeometryProxy) -> CGFloat {
        min(proxy.size.width, proxy.size.height) * 0.1
    }

    /// Size of icon relative to container size
    /// - Parameter proxy: `GeometryProxy`
    /// - Returns: `CGFloat`
    func iconSize(_ proxy: GeometryProxy) -> CGFloat {
        min(proxy.size.width, proxy.size.height) * 0.5
    }

    /// Draw `View`
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                GradientBlurView()
                    .if(showBorder) {
                        $0.modifier(
                            LogoBorder(borderRadius: borderRadius(proxy))
                        )
                    }

                Icon(
                    image: .search,
                    foregroundColor: .appPrimary,
                    size: iconSize(proxy)
                )
            }
        }
    }
}

// MARK: - LogoBorder

/// Modify view to draw a border
private struct LogoBorder: ViewModifier {

    /// Corner radius of the border
    var borderRadius: CGFloat

    /// Modify `content`
    /// - Parameter content: `Content`
    /// - Returns: `View`
    func body(content: Content) -> some View {
        content
            .shapeBorder(RoundedBorder(
                color: .clear,
                cornerRadius: borderRadius
            ))
            .appShadow()
    }
}

// MARK: - PreviewProvider

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(showBorder: true)
            .frame(120)
    }
}

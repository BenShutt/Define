//
//  LogoView.swift
//  Define
//
//  Created by Ben Shutt on 05/10/2022.
//

import SwiftUI

/// View drawing the app logo
struct LogoView: View {

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

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                GradientBlurView(color: .appBlue)
                    .modifier(
                        LogoBorder(borderRadius: borderRadius(proxy))
                    )

                IconView(
                    image: .search,
                    foregroundColor: .appDarkGray,
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
            .cornerRadius(.cornerRadius)
            .compositingGroup()
            .shadow(.container)
    }
}

// MARK: - PreviewProvider

struct LogoView_Previews: PreviewProvider {

    static var previews: some View {
        LogoView()
            .frame(size: 120)
    }
}

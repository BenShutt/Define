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

    /// Overall size
    var size: CGFloat = 1024

    /// Relative size of the icon
    var iconSize: CGFloat {
        size * 0.5
    }

    /// Relative corner radius of the border
    var borderRadius: CGFloat {
        size * 0.1
    }

    /// Draw `View`
    var body: some View {
        Icon(
            image: .search,
            foregroundColor: .appPrimary,
            size: iconSize
        )
        .background(
            GradientBlurView()
                .frame(width: size, height: size)
                .if(showBorder) { logoView in
                    logoView
                        .shapeBorder(
                            RoundedBorder(
                                color: .clear,
                                cornerRadius: borderRadius
                            )
                        )
                        .appShadow()
                }
        )
    }
}

// MARK: - PreviewProvider

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(
            showBorder: true,
            size: UIScreen.main.bounds.width * 0.8
        )
    }
}

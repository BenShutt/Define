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

    /// Render instance as a PNG image
    ///
    /// - Parameter url: `URL` to write to
    /// - Throws: Error writing PNG
    @MainActor
    func renderPNG(writingTo url: URL) throws {
        let renderer = ImageRenderer(content: LogoView())
        let uiImage = try renderer.uiImage ?! LogoRenderError.image
        let pngData = try uiImage.pngData() ?! LogoRenderError.data
        try pngData.write(to: url)
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

// MARK: - LogoError

/// Error rendering logo
enum LogoRenderError: Error {

    /// Failed to get image
    case image

    /// Failed to get data
    case data
}

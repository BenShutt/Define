//
//  AppIconGenerator.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 05/10/2022.
//

import SwiftUI
import AppIcon
import UniformTypeIdentifiers

/// Generates App Icon images from a SwiftUI view.
struct AppIconGenerator {

    /// Directory to write app icon images in
    var directoryURL: URL

    /// Get `URL` for `appIconSize`
    /// - Parameter appIconSize: `AppIconSize`
    /// - Returns: `URL`
    private func url(appIconSize: AppIconSize) -> URL {
        directoryURL.appendingPathComponent("\(appIconSize).png")
    }

    /// Make app icon SwiftUI view
    /// - Parameter size: `AppIconSize`
    /// - Returns: The SwiftUI view
    @ViewBuilder private func view(size: AppIconSize) -> some View {
        AppIcon(size: size.scaledSize, isContainer: false)
    }

    // TODO: Is resizing down better quality? SFSymbol seems a little blurry
    /// Generate app images
    @MainActor func generate() async throws {
        try AppIconSize.all.forEach { size in
            let renderer = ImageRenderer(content: view(size: size))
            renderer.scale = 1
            renderer.proposedSize = .init(width: size.scaledSize, height: size.scaledSize)
            try renderer.write(to: url(appIconSize: size), fileType: .png)
        }
    }
}

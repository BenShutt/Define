//
//  AppIconGenerator.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 05/10/2022.
//

#if canImport(Cocoa)
import SwiftUI
import AppIcon
import UniformTypeIdentifiers

/// Generates App Icon images from a SwiftUI view.
struct AppIconGenerator {

    /// Directory to write app icon images in
    var directoryURL: URL

    /// Get `URL` for `fileName`
    /// - Parameter fileName: Name of the file
    /// - Returns: `URL`
    private func url(fileName: String) -> URL {
        directoryURL.appendingPathComponent("\(fileName).png")
    }

    /// Write SwiftUI view to file
    /// - Parameters:
    ///   - content: View to render
    ///   - size: Size to propose the image is
    ///   - url: Location to write file
    @MainActor private func renderPNG<Content: View>(
        _ content: Content,
        size: CGSize,
        to url: URL
    ) throws {
        let scaleFactor: CGFloat = 3 // iPhone 15 Pro Max
        let renderer = ImageRenderer(content: content)
        renderer.scale = scaleFactor
        renderer.proposedSize = .init(
            width: size.width / scaleFactor,
            height: size.height / scaleFactor
        )
        let nsImage = try renderer.nsImage ?! AppIconGeneratorError.nsImage
        try nsImage.resize(to: size).writePNG(to: url)
    }

    /// Generate app images
    @MainActor func generate() async throws {
        // Render app icons
        try AppIconSize.all.forEach { size in
            try renderPNG(
                AppIcon(size: 1024, isContainer: false),
                size: size.multipliedCGSize,
                to: url(fileName: size.description)
            )
        }

        // Render launch screen
        try renderPNG(
            LaunchScreen(),
            size: .init(width: 1290, height: 2796), // iPhone 15 Pro Max
            to: url(fileName: "launchScreen")
        )
    }
}

// MARK: - AppIconGeneratorError

enum AppIconGeneratorError: Error {
    case nsImage
}
#endif

//
//  AppIcon.swift
//  Define
//
//  Created by Ben Shutt on 05/10/2022.
//

import SwiftUI

/// Generate App Icon
///
/// - Warning:
/// Should be run on a simulator so the images are generated on the (hosting) computer
struct AppIcon {

    /// Name of the directory to write to
    private static let directory = "DefineLogo"

    /// User directory to make `directory` in
    private static let searchPathDirectory: FileManager.SearchPathDirectory = .desktopDirectory

    /// URL to write app icon images to
    private static func directoryURL() throws -> URL {
        try FileManager.default.url(
            for: searchPathDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        .appendingPathComponent(directory)
    }

    /// Render instance as a PNG image
    ///
    /// - Parameters:
    ///   - view: `View`
    ///   - url: `URL` to write to
    private static func renderPNG<T: View>(
        of view: T,
        writingTo url: URL
    ) async throws {
        let renderer = await ImageRenderer(content: view)
        let uiImage = try await renderer.uiImage ?! ImageRendererError.uiImage
        let pngData = try uiImage.pngData() ?! ImageRendererError.pngData
        try pngData.write(to: url)
    }

    /// Write image file
    ///
    /// - Parameters:
    ///   - directoryURL: `URL`
    ///   - appIconSize: `AppIconSize`
    ///   - multiplier: `Int`
    private static func write(
        in directoryURL: URL,
        appIconSize: AppIconSize,
        for multiplier: Int
    ) async throws {
        // Name of the file to write
        let fileName = appIconSize.fileName(for: multiplier, extn: "png")

        // URL to write the file at
        let url = directoryURL.appendingPathComponent(fileName)

        // Make view to render
        let view = LogoView(
            showBorder: false,
            size: appIconSize.sizePx(for: multiplier)
        )

        // Render image and write to file
        try await renderPNG(of: view, writingTo: url)
    }

    /// Generate app icons
    static func generate() async throws {
        let directoryURL = try directoryURL()

        // Remove previous directory
        if FileManager.default.fileExists(atPath: directoryURL.path) {
            try FileManager.default.removeItem(at: directoryURL)
        }

        // Create directory
        try FileManager.default.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true
        )

        for appIconSize in AppIconSize.all {
            for multiplier in appIconSize.multipliers {
                try await write(
                    in: directoryURL,
                    appIconSize: appIconSize,
                    for: multiplier
                )
            }
        }
    }
}

// MARK: - ImageRendererError

/// Error rendering image
enum ImageRendererError: Error {

    /// Failed to get image
    case uiImage

    /// Failed to get data
    case pngData
}

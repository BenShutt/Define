//
//  AppIcon.swift
//  Define
//
//  Created by Ben Shutt on 05/10/2022.
//

import Foundation

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

    /// Write image file
    ///
    /// - Parameters:
    ///   - appIconSize: `AppIconSize`
    ///   - directoryURL: `URL`
    ///   - multiplier: `Int`
    private static func write(
        appIconSize: AppIconSize,
        in directoryURL: URL,
        for multiplier: Int
    ) throws {
        // Name of the file to write
        let fileName = appIconSize.fileName(for: multiplier, extn: "png")

        // URL to write the file at
        let url = directoryURL.appendingPathComponent(fileName)

        // Render image and write to file
        try LogoView(showBorder: false, size: appIconSize.sizePx(for: multiplier))
            .renderPNG(writingTo: url)
    }

    /// Generate app icons
    static func generate() async throws {
        let directoryURL = try directoryURL()

        // Remove previous directory
        try FileManager.default.removeItem(at: directoryURL)

        // Create directory
        try FileManager.default.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true
        )

        try AppIconSize.all.forEach { appIconSize in
            appIconSize.multipliers.forEach { multiplier in
                write(appIconSize: appIconSize, in: directoryURL, for: multiplier)
            }
        }    /// Write image file
        ///
        /// - Parameters:
        ///   - appIconSize: `AppIconSize`
        ///   - directoryURL: `URL`
        ///   - multiplier: `Int`
        private static func write(
            appIconSize: AppIconSize,
            in directoryURL: URL,
            for multiplier: Int
        ) throws {
            // Name of the file to write
            let fileName = appIconSize.fileName(for: multiplier, extn: "png")

            // URL to write the file at
            let url = directoryURL.appendingPathComponent(fileName)

            // Render image and write to file
            try LogoView(showBorder: false, size: appIconSize.sizePx(for: multiplier))
                .renderPNG(writingTo: url)
        }
    }
}

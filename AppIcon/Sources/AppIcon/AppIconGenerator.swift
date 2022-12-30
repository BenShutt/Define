//
//  AppIconGenerator.swift
//  AppIcon
//
//  Created by Ben Shutt on 05/10/2022.
//

import SwiftUI

/// Generates App Icon images from the SwiftUI view: `LogoView`
///
/// - Warning:
/// Should be run on a simulator so the images are generated on the (hosting) computer
///
/// - Note:
/// `ImageRenderer` didn't support UI components like `BlurView`
struct AppIconGenerator {

    /// Name of the directory to write app icon images in
    private static let directory = "DefineLogo"

    /// User (search path) directory to make `directory` in
    private static let searchPathDirectory: FileManager.SearchPathDirectory = .desktopDirectory

    /// `URL` to write app icon images to
    private static func directoryURL() throws -> URL {
        try FileManager.default.url(
            for: searchPathDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        .appendingPathComponent(directory)
    }

    /// The `UIGraphicsImageRendererFormat` to render with
    private static var graphicsFormat: UIGraphicsImageRendererFormat {
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1 // Working in px
        return format
    }

    /// Make directory URL
    private static func makeDirectoryURL() throws -> URL {
        let directoryURL = try directoryURL()

        // Remove previous directory
        if !FileManager.default.fileExists(atPath: directoryURL.path) {
            try FileManager.default.createDirectory(
                at: directoryURL,
                withIntermediateDirectories: true
            )
        }

        return directoryURL
    }

    /// Resize image and write file to directory
    ///
    /// - Parameters:
    ///   - image: `UIImage`
    ///   - appIconSize: `AppIconSize`
    ///   - directoryURL: `URL`
    private static func resizeAndWrite(
        image: UIImage,
        for appIconSize: AppIconSize,
        to directoryURL: URL
    ) throws {
        let fileName = "\(appIconSize).png"
        let url = directoryURL.appendingPathComponent(fileName)
        let newImage = image.resize(to: .init(appIconSize.sizeInPx), format: graphicsFormat)
        guard let pngData = newImage.pngData() else { throw AppIconError.pngData }
        try pngData.write(to: url)
    }

    /// Generate app images
    /// - Parameter view: `AppIconView`
    static func generate<AppIconView: View>(from view: AppIconView) throws {
        let directoryURL = try makeDirectoryURL()

        // Make image from the largest
        let logoImage = view.snapshot(size: .init(AppIconSize.max.sizeInPx))

        // Resize and write all images
        try AppIconSize.all.forEach {
            try resizeAndWrite(image: logoImage, for: $0, to: directoryURL)
        }

        // Log success
        print("Success, app icon images written to \(directoryURL)")
    }
}

// MARK: - AppIconError

/// Error with `AppIcon`
enum AppIconError: Error {

    /// Failed to get data
    case pngData
}

//
//  Main.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 29/09/2023.
//

import SwiftUI
import AppIcon
import ArgumentParser

@main
struct Main: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Generate images from SwiftUI views"
    )

    @Option(help: "The file path of the directory to write the images to")
    var directory: String

    /// Get `URL` of the `directory` file path
    private var directoryURL: URL {
        URL(filePath: (directory as NSString).expandingTildeInPath)
    }

    @MainActor mutating func run() async throws {
        try FileManager.default.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true
        )

        try ImageToWrite(
            fileName: "AppIcon",
            width: 1024,
            height: 1024,
            content: AppIcon(size: 1024, isContainer: false) // TODO: Make sep views for the flag
        )
        .renderAndWrite(in: directoryURL)

        try ImageToWrite(
            fileName: "LaunchScreen",
            width: 1290, // iPhone 15 Pro Max sizing
            height: 2796,
            content: LaunchScreen()
        )
        .renderAndWrite(in: directoryURL)

        print("Success, images written to '\(directoryURL)'")
    }
}

// MARK: - ImageToWrite

@MainActor private struct ImageToWrite<Content: View> {
    var fileName: String
    var width: CGFloat
    var height: CGFloat
    var content: Content

    func renderAndWrite(in directoryURL: URL) throws {
        let url = directoryURL.appendingPathComponent("\(fileName).png")
        let renderer = PNGRenderer(width: width, height: height)
        let data = try renderer.pngData(of: content)
        try data.write(to: url, options: .atomic)
    }
}

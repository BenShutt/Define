//
//  Main.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 29/09/2023.
//

import SwiftUI
import AppIcon
import ArgumentParser
import Utilities

@main
struct Main: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Generate images from their SwiftUI views"
    )

    @Option(help: "The file path of the directory to write the images to")
    var directory: File

    @MainActor mutating func run() async throws {
        try FileManager.default.createDirectory(
            at: directory.url,
            withIntermediateDirectories: true
        )

        try PNGImage(
            directoryURL: directory.url,
            fileName: "AppIcon",
            width: .appIconSize,
            height: .appIconSize
        )
        .renderAndWrite(content: AppIcon())

        try PNGImage(
            directoryURL: directory.url,
            fileName: "LaunchScreen",
            width: .launchScreenWidth,
            height: .launchScreenHeight
        )
        .renderAndWrite(content: LaunchScreen())

        print("Success, images written to '\(directory.url)'")
    }
}

// MARK: - File

struct File: ExpressibleByArgument {
    var url: URL

    init?(argument: String) {
        url = URL(expandingTildeInFilePath: argument)
    }
}

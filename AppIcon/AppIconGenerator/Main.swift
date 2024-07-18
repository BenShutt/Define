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
    var directory: String

    @MainActor mutating func run() async throws {
        let directoryURL = URL(expandingTildeInFilePath: directory)

        try FileManager.default.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true
        )

        try PNGImage(
            directoryURL: directoryURL,
            fileName: "AppIcon",
            width: .appIconSize,
            height: .appIconSize
        )
        .renderAndWrite(content: AppIcon())

        try PNGImage(
            directoryURL: directoryURL,
            fileName: "LaunchScreen",
            width: .launchScreenWidth,
            height: .launchScreenHeight
        )
        .renderAndWrite(content: LaunchScreen())

        print("Success, images written to '\(directoryURL)'")
    }
}

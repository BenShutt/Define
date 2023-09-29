//
//  Main.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 29/09/2023.
//

import Foundation
import ArgumentParser

@main
struct Main: AsyncParsableCommand {

    static let configuration = CommandConfiguration(
        abstract: "Generate app icon images from a SwiftUI view"
    )

    @Option(help: "The path of the directory to write the images to")
    var directory: String

    var directoryURL: URL {
        URL(filePath: (directory as NSString).expandingTildeInPath)
    }

    mutating func run() async throws {
        try FileManager.default.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true
        )
        try await AppIconGenerator(directoryURL: directoryURL).generate()
        print("Success, app icon images written to '\(directoryURL)'")
    }
}

//
//  PNGImage.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 27/06/2024.
//

import SwiftUI
import ViewRenderer

@MainActor
struct PNGImage {
    var directoryURL: URL
    var fileName: String // Without path extension
    var width: CGFloat
    var height: CGFloat

    private var url: URL {
        directoryURL.appendingPathComponent("\(fileName).png")
    }

    func renderAndWrite(content: some View) throws {
        let view = content.frame(width: width, height: height)
        let data = try PNGRenderer().pngData(content: view)
        try data.write(to: url, options: .atomic)
    }
}

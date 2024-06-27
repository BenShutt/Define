//
//  PNGImage.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 27/06/2024.
//

import SwiftUI

@MainActor struct PNGImage {
    var directoryURL: URL
    var fileName: String // Without path extension
    var width: CGFloat
    var height: CGFloat

    private var url: URL {
        directoryURL.appendingPathComponent("\(fileName).png")
    }

    func renderAndWrite(content: some View) throws {
        let renderer = PNGRenderer(width: width, height: height)
        let data = try renderer.pngData(of: content)
        try data.write(to: url, options: .atomic)
    }
}

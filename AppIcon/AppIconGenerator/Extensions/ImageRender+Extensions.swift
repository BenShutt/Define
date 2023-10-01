//
//  ImageRenderer+Extensions.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 01/10/2023.
//

import SwiftUI
import UniformTypeIdentifiers

extension ImageRenderer {

    @MainActor func write(to url: URL, fileType: UTType = .png) throws {
        let image = try cgImage ?! ImageRendererError.cgImage
        let destination = try CGImageDestinationCreateWithURL(
            url as CFURL,
            fileType.identifier as CFString,
            1,
            nil
        ) ?! ImageRendererError.destination

        CGImageDestinationAddImage(destination, image, nil)
        let success = CGImageDestinationFinalize(destination)
        guard success else { throw ImageRendererError.finalize }
    }
}

// MARK: - ImageRendererError

enum ImageRendererError: Error {

    case cgImage
    case destination
    case finalize
}

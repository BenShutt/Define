//
//  PNGRenderer.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 22/06/2024.
//

import SwiftUI

// MARK: - PNGRenderer

/// Renders a PNG image from a SwiftUI view
@MainActor struct PNGRenderer {
    var scale: CGFloat = 1
    var width: CGFloat
    var height: CGFloat

    func pngData(of content: some View) throws -> Data {
        let view = content.frame(width: width, height: height)
        let renderer = ImageRenderer(content: view)
        renderer.scale = scale
        renderer.proposedSize = .init(width: width, height: height)
        let pngData = renderer.pngData()
        guard let pngData else { throw PNGRendererError.pngData }
        return pngData
    }
}

// MARK: - PNGRendererError

enum PNGRendererError: Error {
    case pngData
}

// MARK: - ImageRenderer + Extensions

private extension ImageRenderer {
    @MainActor func pngData() -> Data? {
#if os(iOS)
        uiImage?.pngData()
#elseif os(macOS)
        guard let tiff = nsImage?.tiffRepresentation else { return nil }
        guard let tiffData = NSBitmapImageRep(data: tiff) else { return nil }
        return tiffData.representation(using: .png, properties: [:])
#else
        nil
#endif
    }
}

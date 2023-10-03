//
//  NSImage+Extensions.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 03/10/2023.
//

#if canImport(Cocoa)
import Cocoa

// Ref: https://gist.github.com/raphaelhanneken/cb924aa280f4b9dbb480
extension NSImage {

    private var height: CGFloat {
        size.height
    }

    private var width: CGFloat {
        size.width
    }

    private var pngData: Data? {
        guard let tiff = tiffRepresentation else { return nil }
        guard let tiffData = NSBitmapImageRep(data: tiff) else { return nil }
        return tiffData.representation(using: .png, properties: [:])
    }

    func resize(to size: NSSize) throws -> NSImage {
        let frame = NSRect(x: 0, y: 0, width: size.width, height: size.height)
        let representation = bestRepresentation(for: frame, context: nil, hints: nil)
        let bestRepresentation = try representation ?! NSImageError.representation
        return NSImage(size: size, flipped: false) { _ in
            bestRepresentation.draw(in: frame)
        }
    }

    func writePNG(to url: URL) throws {
        let pngData = try pngData ?! NSImageError.pngData
        try pngData.write(to: url, options: .atomicWrite)
    }
}

// MARK: - NSImageError

enum NSImageError: Error {
    case representation
    case pngData
}
#endif

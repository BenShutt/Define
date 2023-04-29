//
//  WordColor.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import SwiftUI
import CryptoKit
import CubeFoundationSwiftUI

/// Map a word to a color
struct WordColor {

    /// Number of characters in a hex color
    private let hexColorLength = 6

    /// The word to map to a color
    var word: String

    /// Map to hex string
    var hexString: String {
        Data(SHA256.hash(data: Data(word.utf8)))
            .map { String(format: "%02hhx", $0) }
            .joined()
            .prefix(hexColorLength)
            .padding(toLength: hexColorLength, withPad: "f", startingAt: 0)
    }

    /// Map hex string to color
    var color: Color {
        Color(hexString: hexString) ?? .appWhite
    }
}

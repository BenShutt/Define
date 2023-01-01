//
//  Zipped.swift
//  Define
//
//  Created by Ben Shutt on 01/01/2023.
//

import Foundation

/// Index element pair
typealias IndexElement<Element> = (index: Int, element: Element)

// MARK: - Array + IndexElement

extension Array {

    /// Zip index element pair
    var zipped: [IndexElement<Element>] {
        Swift.Array(zip(indices, self))
    }
}

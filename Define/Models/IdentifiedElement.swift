//
//  IdentifiedElement.swift
//  Define
//
//  Created by Ben Shutt on 29/04/2023.
//

import Foundation
import DictionaryAPI

/// An `Identifiable` wrapper of an `Element`
struct IdentifiedElement<Element>: Identifiable {

    /// The unique identifier
    var id: Int

    /// The wrapped `Element`
    var element: Element
}

// MARK: - Extensions

extension Array {

    /// Map to `IdentifiedElement`s
    var identified: [IdentifiedElement<Element>] {
        zipped.map { index, element in
            IdentifiedElement(id: index, element: element)
        }
    }
}

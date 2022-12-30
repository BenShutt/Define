//
//  CGSize+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 06/10/2022.
//

import UIKit

extension CGSize {

    /// Initialize width and height the same value
    /// - Parameter value: `CGFloat`
    init(_ value: CGFloat) {
        self.init(width: value, height: value)
    }
}

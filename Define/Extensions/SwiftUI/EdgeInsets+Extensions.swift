//
//  EdgeInsets+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI

extension EdgeInsets {

    /// Initialize with a single `value`
    ///
    /// - Parameter value: `CGFloat`
    init(_ value: CGFloat) {
        self.init(top: value, leading: value, bottom: value, trailing: value)
    }
}

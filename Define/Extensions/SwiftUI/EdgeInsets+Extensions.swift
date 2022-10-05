//
//  EdgeInsets+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI

extension EdgeInsets {

    /// Initialize all insets to the same value
    ///
    /// - Parameter value: `CGFloat`
    init(_ value: CGFloat) {
        self.init(
            top: value,
            leading: value,
            bottom: value,
            trailing: value
        )
    }

    /// Initialize with vertical and horizontal values
    ///
    /// - Parameters:
    ///   - vertical: `CGFloat`
    ///   - horizontal: `CGFloat`
    init(vertical: CGFloat = 0, horizontal: CGFloat = 0) {
        self.init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }
}

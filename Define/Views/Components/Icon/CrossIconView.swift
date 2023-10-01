//
//  CrossIconView.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Cross icon with tap event
struct CrossIconView: View {

    /// Handle tap
    var onTap: () -> Void

    var body: some View {
        IconContainerView(edge: .trailing) {
            Button(action: onTap) {
                IconView(
                    image: Image(systemName: "xmark.circle.fill"),
                    foregroundColor: .appDarkGray,
                    size: .icon
                )
            }
        }
    }
}

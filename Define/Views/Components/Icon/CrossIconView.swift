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

    /// Draw `View`
    var body: some View {
        IconContainerView {
            Button(action: onTap) {
                Icon(
                    image: .cross,
                    foregroundColor: .appBlue
                )
            }
        }
    }
}

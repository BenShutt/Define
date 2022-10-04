//
//  SearchIconView.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Search icon with gradient background
struct SearchIconView: View {

    /// Draw `View`
    var body: some View {
        IconContainerView(edge: .leading) {
            Icon(
                image: .search,
                foregroundColor: .appDarkBlue
            )
        }
    }
}

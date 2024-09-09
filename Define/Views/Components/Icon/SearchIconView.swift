//
//  SearchIconView.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Search icon with gradient background
struct SearchIconView: View {
    var body: some View {
        IconView(
            image: .magnifyingGlass,
            foregroundColor: .appDarkGray,
            size: .icon
        )
        .iconContainer(edge: .leading)
    }
}

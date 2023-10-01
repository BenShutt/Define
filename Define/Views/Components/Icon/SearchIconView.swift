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
        IconContainerView(edge: .leading) {
            IconView(
                image: Image(systemName: "magnifyingglass"),
                foregroundColor: .appDarkGray,
                size: .icon
            )
        }
    }
}

//
//  LargeNavigationBar.swift
//  Define
//
//  Created by Ben Shutt on 04/11/2023.
//

import SwiftUI

/// View for the large navigation bar state
struct LargeNavigationBar: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey

    var body: some View {
        VStack(alignment: .leading, spacing: .smallMedium) {
            Text(title)
                .textStyle(.h1, fill: .leading)

            Text(subtitle)
                .textStyle(.body, fill: .leading)
        }
        .padding(.horizontal, .hMargin)
        .padding(.vertical, .vMargin + .small)
    }
}

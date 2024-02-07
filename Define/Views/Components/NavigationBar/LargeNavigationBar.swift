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
        VStack(alignment: .leading, spacing: .small) {
            Text(title)
                .h1()
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(subtitle)
                .body()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, .hMargin)
        .padding(.vertical, .vMargin)
    }
}

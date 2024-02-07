//
//  SmallNavigationBar.swift
//  Define
//
//  Created by Ben Shutt on 04/11/2023.
//

import SwiftUI

/// View for the small navigation bar state
struct SmallNavigationBar: View {

    var title: LocalizedStringKey

    var body: some View {
        Text(title)
            .h3()
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, .hMargin)
            .padding(.vertical, .vMargin)
    }
}

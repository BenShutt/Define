//
//  StickyBottom.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import SwiftUI

/// `Screen` with sticky bottom content
struct StickyBottom<Content: View, Bottom: View>: View {

    /// Make `Content` view
    @ViewBuilder var content: () -> Content

    /// Make `Bottom` view
    @ViewBuilder var bottom: () -> Bottom

    /// Screen `View`
    var body: some View {
        VStack(spacing: 0) {
            content()
                .frame(maxHeight: .infinity)
            bottom()
                .background(Color.appWhite)
                .ignoresSafeArea(.keyboard)
                .appShadow()
        }
    }
}

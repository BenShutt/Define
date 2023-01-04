//
//  StickyBottom.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import SwiftUI

/// `Screen` with sticky bottom content
///
/// - Note:
/// Previously implemented using `VStack`.
/// Experienced issues with .toolbarBackground when the content was scrollable.
/// Haven fallen back on "safeAreaInset".
struct StickyBottom<Content: View, Bottom: View>: View {

    /// Make `Content` view
    @ViewBuilder var content: () -> Content

    /// Make `Bottom` view
    @ViewBuilder var bottom: () -> Bottom

    /// Screen `View`
    var body: some View {
        content()
            .safeAreaInset(edge: .bottom) {
                bottom()
                    .background(Color.appWhite)
                    .appShadow()
                    .ignoresSafeArea(.keyboard)
            }
    }
}

// MARK: - PreviewProvider

struct StickyBottom_Previews: PreviewProvider {

    static var previews: some View {
        StickyBottom(content: {
            Rectangle()
                .fill(.red)
        }, bottom: {
            Rectangle()
                .fill(.green)
                .frame(height: 50)
        })
    }
}

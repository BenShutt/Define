//
//  StickyBottom.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import SwiftUI

/// `View` with sticky bottom content
struct StickyBottom<Bottom: View>: ViewModifier {

    /// Make `Bottom` view
    @ViewBuilder var bottom: () -> Bottom

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                bottom()
                    .background(
                        Color.appWhite
                            .ignoresSafeArea()
                            .shadow(.sticky)
                    )
                    .ignoresSafeArea(.keyboard) // Requires container...
            }
    }
}

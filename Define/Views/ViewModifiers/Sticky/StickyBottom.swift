//
//  StickyBottom.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import SwiftUI

private struct StickyBottom<Bottom: View>: ViewModifier {
    @ViewBuilder var bottom: () -> Bottom

    func body(content: Content) -> some View {
        content.safeAreaInset(
            edge: .bottom,
            spacing: 0
        ) {
            VStack(spacing: 0) {
                Separator()
                bottom()
            }
            .background {
                Color.appWhite
                    .stickyShadow()
                    .ignoresSafeArea()
            }
            .ignoresSafeArea(.keyboard)
            .transaction { $0.animation = nil }
        }
    }
}

// MARK: - View + StickyBottom

extension View {
    func stickyBottom(
        @ViewBuilder bottom: @escaping () -> some View
    ) -> some View {
        modifier(StickyBottom(bottom: bottom))
    }
}

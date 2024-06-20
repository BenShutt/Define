//
//  StickyTop.swift
//  NavigationBar
//
//  Created by Ben Shutt on 31/10/2023.
//

import SwiftUI

private struct StickyTop<Top: View>: ViewModifier {
    @ViewBuilder var top: () -> Top

    func body(content: Content) -> some View {
        VStack(spacing: 0) { // Note, not .safeAreaInset(edge: .top)
            top().zIndex(1)
            content
        }
    }
}

// MARK: - View + StickyTop

extension View {
    func stickyTop(
        @ViewBuilder top: @escaping () -> some View
    ) -> some View {
        modifier(StickyTop(top: top))
    }
}

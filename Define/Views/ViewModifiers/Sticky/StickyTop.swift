//
//  StickyTop.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

/// `View` with sticky top content
struct StickyTop<Top: View>: ViewModifier {

    /// Make `Top` view
    @ViewBuilder var top: () -> Top

    func body(content: Content) -> some View {
        VStack(spacing: 0) { // Not .safeAreaInset(edge: .top) here
            top().zIndex(1)
            content
        }
    }
}

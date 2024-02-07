//
//  StickyTop.swift
//  NavigationBar
//
//  Created by Ben Shutt on 31/10/2023.
//

import SwiftUI

/// `View` with sticky top content
public struct StickyTop<Top: View>: ViewModifier {

    /// Make `Top` view
    @ViewBuilder public var top: () -> Top

    public init(top: @escaping () -> Top) {
        self.top = top
    }

    public func body(content: Content) -> some View {
        VStack(spacing: 0) { // Not .safeAreaInset(edge: .top) here
            top().zIndex(1)
            content
        }
    }
}

//
//  NoBounceScrollView.swift
//  Define
//
//  Created by Ben Shutt on 27/04/2023.
//

import SwiftUI

/// A `ScrollView` which uses Introspect to disable bounces on the `UIScrollView`
struct NoBounceScrollView<Content: View>: View {

    var axes: Axis.Set
    var showsIndicators: Bool
    @ViewBuilder var content: () -> Content

    var body: some View {
        ScrollView(
            axes,
            showsIndicators: showsIndicators,
            content: content
        )
        .modifier(BounceBehavior())
    }
}

// MARK: - BounceBehavior

private struct BounceBehavior: ViewModifier {

    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content.scrollBounceBehavior(.basedOnSize)
        } else {
            content
        }
    }
}

// MARK: - Extensions

extension NoBounceScrollView {

    init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            axes: axes,
            showsIndicators: showsIndicators,
            content: content
        )
    }
}

//
//  NoBounceScrollView.swift
//  Define
//
//  Created by Ben Shutt on 27/04/2023.
//

import SwiftUI
import SwiftUIIntrospect

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
        .introspect(.scrollView, on: .iOS(.v16, .v17)) { scrollView in
            if axes.contains(.vertical) {
                scrollView.alwaysBounceVertical = false
            }

            if axes.contains(.horizontal) {
                scrollView.alwaysBounceHorizontal = false
            }
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

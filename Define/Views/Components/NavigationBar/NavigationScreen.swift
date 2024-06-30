//
//  NavigationScreen.swift
//  Define
//
//  Created by Ben Shutt on 07/02/2024.
//

import SwiftUI

struct NavigationScreen<Content: View, NavigationContent: View>: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    @ViewBuilder var content: () -> Content
    @ViewBuilder var navigationContent: () -> NavigationContent

    @State private var offsetY: CGFloat = 0
    @State private var smallNavigationBarHeight: CGFloat = 0
    @State private var largeNavigationBarHeight: CGFloat = 0
    @State private var navigationContentHeight: CGFloat = 0

    /// Pad the scroll view content by the difference between the expanded and collapsed navigation bar
    private var contentTopPadding: CGFloat {
        max(0, largeNavigationBarHeight - smallNavigationBarHeight)
    }

    /// Pad the scroll view by the height of the navigation bar in the collapsed state
    private var scrollTopPadding: CGFloat {
        smallNavigationBarHeight + navigationContentHeight
    }

    var body: some View {
        OffsetScrollView(
            onOffsetChange: { offsetY = $0.y },
            content: {
                content()
                    .padding(.top, contentTopPadding)
            }
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, scrollTopPadding)
        .overlay(alignment: .top) {
            VStack(spacing: 0) {
                NavigationBar(
                    offsetY: offsetY,
                    maxOffsetY: contentTopPadding,
                    smallNavigationBar: {
                        SmallNavigationBar(title: title)
                            .onSizeChanged { smallNavigationBarHeight = $0.height }
                    },
                    largeNavigationBar: {
                        LargeNavigationBar(title: title, subtitle: subtitle)
                            .onSizeChanged { largeNavigationBarHeight = $0.height }
                    }
                )

                navigationContent()
                    .onSizeChanged { navigationContentHeight = $0.height }
            }
            .background {
                NavigationBarBackground()
            }
        }
        .screen()
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Preview

#Preview {
    NavigationScreen(
        title: "home_title",
        subtitle: "home_subtitle",
        content: {
            LazyVStack(spacing: 0) {
                ForEach(0..<10) { _ in
                    Color.gray
                        .frame(height: 50)
                        .padding(.vertical)
                }
            }
        }, navigationContent: {}
    )
}

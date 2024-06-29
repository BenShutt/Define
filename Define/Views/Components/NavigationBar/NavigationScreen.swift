//
//  NavigationScreen.swift
//  Define
//
//  Created by Ben Shutt on 07/02/2024.
//

import SwiftUI

struct NavigationScreen<Content: View>: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    @ViewBuilder var content: () -> Content

    @State private var offset: CGPoint = .zero
    @State private var smallNavigationBarHeight: CGFloat = 0
    @State private var largeNavigationBarHeight: CGFloat = 0

    private var contentTopPadding: CGFloat {
        max(0, largeNavigationBarHeight - smallNavigationBarHeight)
    }

    private var scrollTopPadding: CGFloat {
        max(0, smallNavigationBarHeight)
    }

    var body: some View {
        OffsetScrollView(
            onOffsetChange: { offset = $0 },
            content: {
                content()
                    .padding(.top, contentTopPadding)
            }
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, scrollTopPadding)
        .overlay(alignment: .top) {
            NavigationBar(
                offsetY: offset.y,
                smallNavigationBar: {
                    SmallNavigationBar(title: title)
                        .onSizeChanged { smallNavigationBarHeight = $0.height }
                },
                largeNavigationBar: {
                    LargeNavigationBar(title: title, subtitle: subtitle)
                        .onSizeChanged { largeNavigationBarHeight = $0.height }
                }
            )
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
        })
}

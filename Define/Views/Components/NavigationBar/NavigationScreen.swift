//
//  NavigationScreen.swift
//  Define
//
//  Created by Ben Shutt on 07/02/2024.
//

import SwiftUI
import NavigationBar

struct NavigationScreen<Content: View>: View {

    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey

    @State private var offset: CGPoint = .zero
    @ViewBuilder var content: () -> Content

    var body: some View {
        OffsetScrollView(offset: $offset, content: content)
            .screen()
            .modifier(StickyTop {
                NavigationBar(
                    offsetY: offset.y,
                    smallNavigationBar: {
                        SmallNavigationBar(title: title)
                    },
                    largeNavigationBar: {
                        LargeNavigationBar(title: title, subtitle: subtitle)
                    },
                    background: {
                        NavigationBarBackground()
                    }
                )
            })
    }
}

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

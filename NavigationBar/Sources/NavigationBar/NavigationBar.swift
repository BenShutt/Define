//
//  NavigationBar.swift
//  NavigationBar
//
//  Created by Ben Shutt on 31/10/2023.
//

import SwiftUI

/// Custom view used for navigation bar UI.
/// The view transitions from a large to small state as the scroll offset increases.
public struct NavigationBar<SmallContent: View, LargeContent: View>: View {

    /// Critical scroll offset in Y for the different states
    private let maxOffsetY: CGFloat = 100

    /// The content offset in Y of the scroll view
    public var offsetY: CGFloat

    /// Make the small navigation bar content
    @ViewBuilder public var smallNavigationBar: () -> SmallContent

    /// Make the large navigation bar content
    @ViewBuilder public var largeNavigationBar: () -> LargeContent

    /// Value in `[0, 1]` from not scrolled to fully scrolled (respectively)
    private var progress: CGFloat {
        // TODO: Handle bounce the other way
        max(0, min(maxOffsetY, offsetY)) / maxOffsetY
    }

    /// Opacity of the small navigation bar as a function of progress
    private var smallOpacity: CGFloat {
        max(0, 2 * progress - 1)
    }

    /// Opacity of the large navigation bar as a function of progress
    private var largeOpacity: CGFloat {
        max(0, 1 - 2 * progress)
    }

    /// Offset in Y of the large navigation bar as a function of progress
    private var largeOffset: CGFloat {
        min(0, max(-offsetY, -maxOffsetY))
    }

    public init(
        offsetY: CGFloat,
        smallNavigationBar: @escaping () -> SmallContent,
        largeNavigationBar: @escaping () -> LargeContent
    ) {
        self.offsetY = offsetY
        self.smallNavigationBar = smallNavigationBar
        self.largeNavigationBar = largeNavigationBar
    }

    public var body: some View {
        ZStack(alignment: .top) {
            smallNavigationBar()
                .opacity(smallOpacity)

            largeNavigationBar()
                .opacity(largeOpacity)
                .offset(y: largeOffset)
                .modifier(ClippedHeight { maxHeight in
                    maxHeight * (1 - progress)
                })
        }
    }
}

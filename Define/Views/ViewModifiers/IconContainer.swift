//
//  IconContainer.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Container of an icon view
struct IconContainer: ViewModifier {

    /// Horizontal edge
    enum Edge {

        /// Is leading edge
        case leading

        /// Is trailing edge
        case trailing
    }

    /// Edge
    var edge: Edge

    /// Leading padding
    private var leadingPadding: CGFloat {
        switch edge {
        case .leading: return .large
        case .trailing: return .medium
        }
    }

    /// Trailing padding
    private var trailingPadding: CGFloat {
        switch edge {
        case .leading: return .medium
        case .trailing: return .large
        }
    }

    func body(content: Content) -> some View {
        content
            .padding(.leading, leadingPadding)
            .padding(.trailing, trailingPadding)
    }
}

// MARK: - View + IconContainer

extension View {
    func iconContainer(edge: IconContainer.Edge) -> some View {
        modifier(IconContainer(edge: edge))
    }
}

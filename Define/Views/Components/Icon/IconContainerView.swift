//
//  IconContainerView.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Container of an icon view
struct IconContainerView<Body: View>: View {

    /// Horizontal edge
    enum Edge {

        /// Is leading edge
        case leading

        /// Is trailing edge
        case trailing
    }

    /// Edge
    var edge: Edge

    /// Make content view
    @ViewBuilder var contentView: Body

    /// Leading padding
    var leadingPadding: CGFloat {
        switch edge {
        case .leading: return .large
        case .trailing: return .medium
        }
    }

    /// Trailing padding
    var trailingPadding: CGFloat {
        switch edge {
        case .leading: return .medium
        case .trailing: return .large
        }
    }

    /// Draw `View`
    var body: some View {
        contentView
            .padding(.leading, leadingPadding)
            .padding(.trailing, trailingPadding)
    }
}

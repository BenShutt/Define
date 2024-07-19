//
//  CrossIconView.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Cross icon with tap event
struct CrossIconView: View {

    /// Handle tap
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            CrossIcon()
        }
        .iconContainer(edge: .trailing)
    }
}

// MARK: - CrossIcon

struct CrossIcon: View {
    var size: CGFloat = .icon

    var body: some View {
        IconView(
            image: Image(.crossCircleFill),
            foregroundColor: .appDarkGray,
            size: size
        )
    }
}

// MARK: - CrossButton

struct CrossButton: View {
    private let size: CGFloat = .icon
    var action: () -> Void

    var touchAreaPadding: CGFloat {
        max(0, .minTouchArea - size) * 0.5
    }

    var body: some View {
        Button(action: action, label: {
            CrossIcon(size: size)
                .padding(touchAreaPadding)
        })
    }
}

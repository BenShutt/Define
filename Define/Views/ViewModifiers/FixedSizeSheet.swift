//
//  FixedSizeSheet.swift
//  Define
//
//  Created by Ben Shutt on 24/06/2024.
//

import SwiftUI

private struct FixedSizeSheet: ViewModifier {
    @State private var contentHeight: CGFloat = 0
    var maxHeight: CGFloat

    private var height: CGFloat {
        min(contentHeight, maxHeight)
    }

    func body(content: Content) -> some View {
        ScrollView {
            content
                .onSizeChanged { contentHeight = $0.height }
        }
        .scrollBounceBasedOnSize()
        .frame(height: height)
        .fixedSize(horizontal: false, vertical: true)
        .presentationDetents([.height(height)])
        .presentationDragIndicator(.visible)
        .padding(.top) // For presentation drag indicator
    }
}

// MARK: - View + FixedSizeSheet

extension View {
    func fixedSizeSheet(maxHeight: CGFloat = 450) -> some View {
        modifier(FixedSizeSheet(maxHeight: maxHeight))
    }
}

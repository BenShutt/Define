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
                .onSizeChange { contentHeight = $0.height }
        }
        .scrollDisabled(contentHeight <= maxHeight)
        .scrollBounceBehavior(.basedOnSize)
        .frame(height: height)
        .fixedSize(horizontal: false, vertical: true)
        .presentationDetents([.height(height)])
        .presentationDragIndicator(.visible)
        .padding(.top, 5) // For presentation drag indicator
    }
}

// MARK: - View + FixedSizeSheet

extension View {
    func fixedSizeSheet(maxHeight: CGFloat = 450) -> some View {
        modifier(FixedSizeSheet(maxHeight: maxHeight))
    }
}

// MARK: - Preview

private struct PreviewView: View {
    @State private var isPresenting = false
    private let height: CGFloat = 800

    var body: some View {
        Button(action: {
            isPresenting = true
        }, label: {
            Text("continue_button")
        })
        .sheet(isPresented: $isPresenting) {
            Color.blue
                .frame(height: height)
                .fixedSizeSheet(maxHeight: 450)
        }
    }
}

#Preview {
    PreviewView()
}

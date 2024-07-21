//
//  AnimatedScrollView.swift
//  Define
//
//  Created by Ben Shutt on 10/10/2023.
//

import SwiftUI

/// Scroll view that animates its contents when they appear based on their index
/// - Warning: Using a `VStack` instead of `LazyVStack` so that `onAppear` works as expected
struct AnimatedScrollView<Element, Content: View>: View {
    @State private var appearedItems: Set<Int> = []
    var elements: [Element]
    @ViewBuilder var content: (Int, Element) -> Content

    var body: some View {
        ScrollView {
            VStack(spacing: .vMargin) {
                ForEach(elements.zipped, id: \.0) { index, element in
                    content(index, element)
                        .modifier(OnAppearAnimator(
                            appearedItems: $appearedItems,
                            index: index
                        ))
                }
            }
            .padding(.margins)
        }
    }
}

// MARK: - OnAppearAnimator

private struct OnAppearAnimator: ViewModifier {
    @Binding var appearedItems: Set<Int>
    var index: Int

    private var delay: TimeInterval {
        TimeInterval(index) * 0.15
    }

    private var opacity: CGFloat {
        appearedItems.contains(index) ? 1 : 0
    }

    private var offsetY: CGFloat {
        appearedItems.contains(index) ? 0 : -30
    }

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: offsetY)
            .onAppear {
                guard !appearedItems.contains(index) else { return }
                _ = withAnimation(.linear(duration: 0.25).delay(delay)) {
                    appearedItems.insert(index)
                }
            }
    }
}

// MARK: - Preview

private struct PreviewColorView: View {
    var index: Int
    var color: Color
    var height: CGFloat = 200

    private var shape: RoundedRectangle {
        .init(cornerRadius: height / 10)
    }

    var body: some View {
        color
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .overlay {
                Text(index, format: .number)
                    .textStyle(.h1)
                    .padding(height / 10)
                    .background(Color.appLightGray)
                    .clipShape(shape)
            }
            .clipShape(shape)
    }
}

private struct PreviewView: View {
    @State private var appearedItems: Set<Int> = []

    private var colors: [Color] {
        (1...20).map { _ in .random() }
    }

    var body: some View {
        AnimatedScrollView(elements: colors) { index, color in
            PreviewColorView(index: index, color: color)
        }
    }
}

#Preview {
    PreviewView()
}

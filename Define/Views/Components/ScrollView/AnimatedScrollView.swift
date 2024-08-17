//
//  AnimatedScrollView.swift
//  Define
//
//  Created by Ben Shutt on 10/10/2023.
//

import SwiftUI

/// Scroll view that animates its contents based on index
/// - Warning: `onAppear` can not be relied upon when scrolling a `LazyVStack`
struct AnimatedScrollView<Element, Content: View>: View {
    @State private var hasAppeared = false

    var elements: [Element]
    @ViewBuilder var content: (Int, Element) -> Content

    var body: some View {
        ScrollView {
            LazyVStack(spacing: .vMargin) {
                ForEach(elements.zipped, id: \.0) { index, element in
                    content(index, element)
                        .modifier(OnAppearAnimator(
                            index: index,
                            hasAppeared: hasAppeared
                        ))
                }
            }
            .padding(.margins)
        }
        .onAppear {
            withAnimation {
                hasAppeared = true
            }
        }
    }
}

// MARK: - OnAppearAnimator

private struct OnAppearAnimator: ViewModifier {
    var index: Int
    var hasAppeared = false

    private var delay: TimeInterval {
        TimeInterval(index) * 0.2
    }

    func body(content: Content) -> some View {
        content
            .opacity(hasAppeared ? 1 : 0)
            .offset(y: hasAppeared ? 0 : 50)
            .animation(.easeIn.delay(delay), value: hasAppeared)
    }
}

// MARK: - Preview

private struct PreviewView: View {
    var colorHeight: CGFloat = 200

    private let colors = {
        (1...20).map { _ in Color.random() }
    }()

    private var shape: some InsettableShape {
        RoundedRectangle(cornerRadius: colorHeight / 10)
    }

    var body: some View {
        AnimatedScrollView(elements: colors) { index, color in
            color
                .frame(height: colorHeight)
                .frame(maxWidth: .infinity)
                .overlay {
                    Text(index, format: .number)
                        .textStyle(.h1)
                        .padding(colorHeight / 10)
                        .background(Color.appLightGray)
                        .clipShape(shape)
                }
                .clipShape(shape)
        }
    }
}

#Preview {
    PreviewView()
}

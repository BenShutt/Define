//
//  ListAnimator.swift
//  Define
//
//  Created by Ben Shutt on 10/10/2023.
//

import SwiftUI

private struct ListAnimator: ViewModifier {
    @Binding var appearedItems: Set<Int>
    var index: Int
    var isEnabled: Bool

    private var delay: TimeInterval {
        TimeInterval(index) * 0.15
    }

    private var opacity: CGFloat {
        !isEnabled || appearedItems.contains(index) ? 1 : 0
    }

    private var offsetY: CGFloat {
        !isEnabled || appearedItems.contains(index) ? 0 : -30
    }

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .offset(y: offsetY)
            .onAppear {
                guard isEnabled, !appearedItems.contains(index) else { return }
                _ = withAnimation(.linear(duration: 0.25).delay(delay)) {
                    appearedItems.insert(index)
                }
            }
    }
}

// MARK: - View + ListAnimator

extension View {
    func listAnimator(
        appearedItems: Binding<Set<Int>>,
        index: Int,
        isEnabled: Bool = true
    ) -> some View {
        modifier(ListAnimator(
            appearedItems: appearedItems,
            index: index,
            isEnabled: isEnabled
        ))
    }
}

// MARK: - Preview

private struct PreviewColorView: View {
    var index: Int
    var color: Color

    var body: some View {
        color
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .clipShape(.rect(cornerRadius: .small))
            .padding(5)
            .overlay {
                Text(index, format: .number)
                    .textStyle(.h1, textColor: .appDarkGray)
                    .padding(5)
                    .background(Color.appLightGray)
                    .clipShape(.rect(cornerRadius: .small))
            }
    }
}

private struct PreviewView: View {
    @State private var appearedItems: Set<Int> = []

    private var colors: [Color] {
        (0..<20).map { _ in .random() }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(colors.zipped, id: \.0) { index, color in
                    PreviewColorView(index: index, color: color)
                        .listAnimator(
                            appearedItems: $appearedItems,
                            index: index
                        )
                }
            }
        }
    }
}

#Preview {
    PreviewView()
}

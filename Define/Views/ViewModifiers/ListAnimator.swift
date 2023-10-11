//
//  ListAnimator.swift
//  Define
//
//  Created by Ben Shutt on 10/10/2023.
//

import SwiftUI

struct ListAnimator: ViewModifier {

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
            .task {
                guard !appearedItems.contains(index) else { return }
                _ = withAnimation(.linear(duration: 0.25).delay(delay)) {
                    appearedItems.insert(index)
                }
            }
    }
}

// MARK: - Preview

private struct PreviewView: View {

    @State private var appearedItems: Set<Int> = []

    private var random: Double {
        .random(in: 0...1)
    }

    private var colors: [Color] {
        (0..<20).map { _ in
            Color(red: random, green: random, blue: random)
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(colors.zipped, id: \.0) { index, color in
                    color
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .compositingGroup()
                        .shadow(.container)
                        .padding(5)
                        .modifier(ListAnimator(
                            appearedItems: $appearedItems,
                            index: index
                        ))
                }
            }
        }
    }
}

#Preview {
    PreviewView()
}

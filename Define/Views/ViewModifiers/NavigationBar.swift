//
//  NavigationBar.swift
//  Define
//
//  Created by Ben Shutt on 30/06/2024.
//

import SwiftUI

/// Uses the default iOS navigation bar applying a custom background and title styling
struct NavigationBar: ViewModifier {
    var title: String

    func body(content: Content) -> some View {
        GeometryReader { metrics in
            content
                .overlay(alignment: .top) {
                    NavigationBarBackground()
                        .frame(height: metrics.safeAreaInsets.top)
                        .ignoresSafeArea(edges: .top)
                }
        }
        .toolbarBackground(Color.clear, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(verbatim: title)
                    .textStyle(.h3)
            }
        }
    }
}

extension View {
    func navigationBar(title: String) -> some View {
        modifier(NavigationBar(title: title))
    }

    func navigationBar(title: LocalizedStringResource) -> some View {
        navigationBar(title: .init(localized: title))
    }
}

// MARK: - Preview

private struct PreviewView: View {
    @State private var isPushed = true

    var body: some View {
        NavigationStack {
            Color.clear
                .navigationDestination(isPresented: $isPushed) {
                    PreviewDetailView()
                }
        }
    }
}

private struct PreviewDetailView: View {
    var body: some View {
        VStack(spacing: 0) {
            Color.red
                .frame(height: 1)
            Color.gray
        }
        .navigationBar(title: "Preview")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}, label: {
                    Image(.plus)
                        .foregroundStyle(Color.appDarkGray)
                })
            }
        }
    }
}

#Preview {
    PreviewView()
}

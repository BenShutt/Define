//
//  OffsetScrollView.swift
//  NavigationBar
//
//  Created by Ben Shutt on 04/11/2023.
//

import SwiftUI

// TODO: Is a @Binding less performant than a closure?
public struct OffsetScrollView<Content: View>: View {

    private let coordinateSpace = "\(Self.self)"
    @Binding public var offset: CGPoint
    @ViewBuilder public var content: () -> Content

    public init(
        offset: Binding<CGPoint>,
        content: @escaping () -> Content
    ) {
        self._offset = offset
        self.content = content
    }

    public var body: some View {
        ScrollView {
            content()
                .background(
                    GeometryView(coordinateSpace: coordinateSpace)
                )
        }
        .coordinateSpace(name: coordinateSpace)
        .onPreferenceChange(ScrollOffset.self) { value in
            offset = value
        }
    }
}

// MARK: - GeometryView

private struct GeometryView: View {

    var coordinateSpace: String

    var body: some View {
        GeometryReader { proxy in
            Color.clear.preference(
                key: ScrollOffset.self,
                value: {
                    let origin = proxy.frame(in: .named(coordinateSpace)).origin
                    return CGPoint(x: -origin.x, y: -origin.y)
                }()
            )
        }
    }
}

// MARK: - ScrollOffset

private struct ScrollOffset: PreferenceKey {

    static let defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

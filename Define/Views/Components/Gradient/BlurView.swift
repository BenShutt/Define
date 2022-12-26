//
//  BlurView.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI

/// A `UIViewRepresentable` wrapping a `UIVisualEffectView` with a `UIBlurEffect`
struct BlurView: UIViewRepresentable {

    /// Blur effect style
    var style: UIBlurEffect.Style = .regular

    /// Make `UIVisualEffectView`
    ///
    /// - Parameter context: `Context`
    /// - Returns: `UIVisualEffectView`
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    /// Update `uiView`
    ///
    /// - Parameters:
    ///   - uiView: `UIVisualEffectView`
    ///   - context: `Context`
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

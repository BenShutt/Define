//
//  SearchEmptyView.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import SwiftUI
import Lottie

/// `View` that draws a search empty state
struct SearchEmptyView: View {

    /// Lottie animation
    var lottie: LottieFile

    /// Lottie animation loop mode
    var loopMode: LottieLoopMode = .loop

    /// Transform for lottie
    var lottieTransform: CGAffineTransform = .identity

    /// Title text
    var title: LocalizedStringKey

    /// Subtitle text
    var subtitle: LocalizedStringKey

    /// Padding to add to stack
    var padding: EdgeInsets = .init(
        top: .large + .vMargin,
        leading: .hMargin,
        bottom: .vMargin,
        trailing: .hMargin
    )

    var body: some View {
        VStack(spacing: 0) {
            LottieView(
                file: lottie,
                loopMode: loopMode,
                transform: lottieTransform
            )
            .frame(width: 300, height: 100)

            Text(title)
                .textStyle(.h1, fill: .center)
                .padding(.top, .large)

            Text(subtitle)
                .textStyle(.body, fill: .center)
                .padding(.top, .medium)
        }
        .padding(padding)
    }
}

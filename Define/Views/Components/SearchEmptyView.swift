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
    var title: String

    /// Subtitle text
    var subtitle: String

    /// Draw `View`
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LottieView(
                file: lottie,
                loopMode: loopMode,
                transform: lottieTransform
            )
            .frame(width: 300, height: 100)

            Text(title)
                .h1()
                .padding(.top, .large)

            Text(subtitle)
                .body()
                .padding(.top, .medium)
        }
        .multilineTextAlignment(.center)
        .padding(.margins)
    }
}

//
//  SearchEmptyView.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import SwiftUI
import Lottie

/// `View` that draws a search empty state
protocol SearchEmptyView: View {

    /// Lottie animation
    var lottie: LottieFile { get }

    /// Lottie animation loop mode
    var loopMode: LottieLoopMode { get }

    /// Title text
    var title: String { get }

    /// Subtitle text
    var subtitle: String { get }
}

// MARK: - View

extension SearchEmptyView {

    var loopMode: LottieLoopMode {
        .loop
    }

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            LottieView(file: lottie, loopMode: loopMode)
                .frame(width: 300, height: 100)

            Spacer()
                .frame(height: .large)

            Text(title)
                .textStyle(.title)
                .multilineTextAlignment(.center)

            Spacer()
                .frame(height: .medium)

            Text(subtitle)
                .textStyle(.body)
                .foregroundColor(.appDarkGray)
                .multilineTextAlignment(.center)
        }
        .padding(.margins)
    }
}

//
//  ThankYouScreen.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2024.
//

import SwiftUI
import Lottie

struct ThankYouScreen: View {
    @Environment(\.popToRoot) private var popToRoot

    var body: some View {
        GeometryReader { metrics in
            VStack(spacing: 0) {
                LottieView(.tick)
                    .playing(loopMode: .playOnce)
                    .animationSpeed(0.75)
                    .aspectRatio(contentMode: .fit)
                    .transform(lottie: .tick)
                    .frame(width: metrics.size.width * 0.8)
                    .overlay {
                        LottieView(.confetti)
                            .playing(loopMode: .playOnce)
                            .aspectRatio(contentMode: .fill)
                            .transform(lottie: .confetti)
                            .frame(width: metrics.size.width * 1.5)
                            .fixedSize()
                    }

                Text("thank_you_title")
                    .textStyle(.h1, fill: .leading)
                    .padding(.top, .medium)

                Text("thank_you_subtitle")
                    .textStyle(.body, fill: .leading)
                    .padding(.top, .medium)

                Spacer(minLength: 0)
            }
            .padding(.margins)
            .background {
                GradientBlurView()
                    .rotationEffect(.degrees(180))
                    .ignoresSafeArea()
            }
        }
        .screen()
        .stickyButton(
            title: "back_button",
            systemName: .arrowBack,
            onTap: {
                popToRoot()
            }
        )
    }
}

// MARK: - Preview

#Preview {
    ThankYouScreen()
}

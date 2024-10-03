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
                    .aspectRatio(contentMode: .fill)
                    .transform(lottie: .tick)
                    .frame(height: metrics.size.height * 0.5)
                    .overlay {
                        LottieView(.confetti)
                            .playing(loopMode: .playOnce)
                            .aspectRatio(contentMode: .fill)
                            .transform(lottie: .confetti)
                            .frame(width: metrics.size.width)
                            .fixedSize()
                    }

                Text("thank_you_title")
                    .textStyle(.h1, fill: .leading)
                    .padding(.top, .medium)

                Text(.init("thank_you_subtitle"))
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
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview

#Preview {
    ThankYouScreen()
}

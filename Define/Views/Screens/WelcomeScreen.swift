//
//  WelcomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 23/08/2023.
//

import SwiftUI
import AppIcon

struct WelcomeScreen: Screen {

    @State private var animationValue = 0
    var onContinue: () -> Void

    private var appName: String {
        Bundle.main.appName ?? ""
    }

    var screen: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                WelcomeHeaderView(
                    animationValue: $animationValue,
                    color: .appBlue
                )
                .frame(maxWidth: .infinity)

                Text(verbatim: .WelcomeScreen.title(appName: appName))
                    .h1()
                    .padding(.top, 2 * .extraLarge)
                    .padding(.horizontal, .hMargin)

                Text(verbatim: .WelcomeScreen.subtitle(appName: appName))
                    .body()
                    .padding(.top, .large)
                    .padding(.horizontal, .hMargin)
            }
            .multilineTextAlignment(.leading)
            .padding(.bottom, .vMargin)
        }
        .ignoresSafeArea(.all, edges: .top)
        .stickyButton(
            title: .Misc.continueButton,
            systemName: "arrow.forward"
        ) {
            onContinue()
        }
        .task {
            try? await Task.sleep(for: .seconds(1)) // Mask throw
            animationValue = max(animationValue, 1)
        }
    }
}

// MARK: - WelcomeHeaderView

private struct WelcomeHeaderView: View {

    private let backgroundHeight: CGFloat = 200
    private let iconHeight: CGFloat = 150

    @Binding var animationValue: Int
    var color: Color

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [
                    color.opacity(0.1),
                    color.opacity(0.5)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: backgroundHeight)
            .background(Color.appWhite)
            .clipShape(CurvedBottom())
            .compositingGroup()
            .shadow(radius: 5)

            AppIcon(
                size: iconHeight,
                color: color,
                animationValue: $animationValue
            )
            .padding(.top, backgroundHeight - iconHeight * 0.75)
        }
    }
}

// MARK: - WelcomeHeaderShape

private struct CurvedBottom: Shape {

    private let yScale: CGFloat = 0.8

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.minX, y: rect.minY))
        path.addLine(to: .init(x: rect.maxX, y: rect.minY))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY * yScale))
        path.addQuadCurve(
            to: .init(x: rect.minX, y: rect.maxY * yScale),
            control: .init(x: rect.midX, y: rect.maxY)
        )
        path.closeSubpath()
        return path
    }
}

// MARK: - PreviewProvider

#Preview {
    WelcomeScreen {}
}

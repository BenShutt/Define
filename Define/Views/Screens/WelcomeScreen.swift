//
//  WelcomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 23/08/2023.
//

import SwiftUI
import AppIcon

struct WelcomeScreen: View {
    @State private var animationValue = 0
    var onContinue: (Bool) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                WelcomeHeaderView(animationValue: animationValue)

                Text("welcome_title")
                    .textStyle(.h1, fill: .leading)
                    .padding(.top, 2 * .extraLarge)
                    .padding(.horizontal, .hMargin)

                Text("welcome_subtitle \(appNameOrDefault)")
                    .textStyle(.body, fill: .leading)
                    .padding(.top, .large)
                    .padding(.horizontal, .hMargin)
            }
            .padding(.bottom, .vMargin)
        }
        .scrollBounceBasedOnSize()
        .ignoresSafeArea(.all, edges: .top)
        .screen()
        .toolbar(.hidden, for: .navigationBar)
        .stickyButton(
            title: "continue_button",
            systemName: "arrow.forward"
        ) {
            PushNotificationManager.requestRemoteNotificationPermission { granted in
                onContinue(granted)
            }
        }
        .task {
            try? await Task.sleep(for: .milliseconds(500))
            animationValue = max(animationValue, 1)
        }
    }
}

// MARK: - WelcomeHeaderView

private struct WelcomeHeaderView: View {
    private let backgroundHeight: CGFloat = 250
    private let iconHeight: CGFloat = 150

    var animationValue: Int
    var color: Color = .default

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
            .frame(maxWidth: .infinity)
            .frame(height: backgroundHeight)
            .background(Color.appWhite)
            .clipShape(CurvedBottom())
            .compositingGroup()
            .shadow(.sticky)

            AppIcon(
                color: color,
                animationValue: animationValue
            )
            .frame(width: iconHeight, height: iconHeight)
            .appIconContainer(color: color)
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

// MARK: - OnboardingModifier

private struct OnboardingModifier: ViewModifier {
    @EnvironmentObject private var settings: UserSettings
    @State private var isPresented = false

    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                WelcomeScreen { _ in
                    settings.hasSeenWelcome = true
                    isPresented = false
                }
            }
            .task {
                isPresented = !settings.hasSeenWelcome
            }
    }
}

// MARK: View + OnboardingModifier

extension View {
    func presentOnboarding() -> some View {
        modifier(OnboardingModifier())
    }
}

// MARK: - Preview

#Preview {
    WelcomeScreen { _ in }
}

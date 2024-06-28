//
//  OnboardingModifier.swift
//  Define
//
//  Created by Ben Shutt on 27/06/2024.
//

import SwiftUI

private struct OnboardingModifier: ViewModifier {

    // TODO: Line length
    @AppStorage(UserDefaultKey.hasSeenWelcome.rawValue) private var hasSeenWelcome = false

    func body(content: Content) -> some View {
        content
            .overlay {
                if !hasSeenWelcome {
                    WelcomeScreen { _ in
                        withAnimation {
                            hasSeenWelcome = true
                        }
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
    }
}

// MARK: View + OnboardingModifier

extension View {
    func presentOnboarding() -> some View {
        modifier(OnboardingModifier())
    }
}

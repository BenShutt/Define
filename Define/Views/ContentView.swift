//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI
import DictionaryAPI

struct ContentView: View {
    var body: some View {
        AppTabView()
            .overlay {
                OnboardingView()
            }
    }
}

// MARK: - OnboardingView

struct OnboardingView: View {

    /// Has the user seen the welcome screen
    @AppStorage(UserDefaultKey.hasSeenWelcome.rawValue) private var hasSeenWelcome = false

    private func onContinue() {
        PushNotificationManager.requestRemoteNotificationPermission { _ in
            // TODO: Check if works when already accepted
            withAnimation {
                hasSeenWelcome = true
            }
        }
    }

    var body: some View {
        if !hasSeenWelcome {
            WelcomeScreen(onContinue: onContinue)
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }
}

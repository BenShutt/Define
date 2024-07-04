//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI
import DictionaryAPI

struct ContentView: View {
    @EnvironmentObject private var notifications: NotificationManager

    var body: some View {
        RootNavigationStack {
            RootScreen()
                .routeWordReminders()
        }
        .tint(.appDarkGray) // Back button etc
        .presentOnboarding()
        .onReceive(.willPresentNotification) { _ in
            notifications.updateIdentifiers()
        }
    }
}

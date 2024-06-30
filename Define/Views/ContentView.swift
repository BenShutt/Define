//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI
import DictionaryAPI

struct ContentView: View {
    @EnvironmentObject private var manager: NotificationManager

    var body: some View {
        RootNavigationStack {
            RootScreen()
                .routeWordReminders()
        }
        .tint(.appDarkGray)
        .presentOnboarding()
        .onReceive(.willPresent) { _ in
            manager.updateIdentifiers()
        }
    }
}

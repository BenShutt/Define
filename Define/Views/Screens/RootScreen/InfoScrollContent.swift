//
//  InfoScrollContent.swift
//  Define
//
//  Created by Ben Shutt on 26/06/2024.
//

import SwiftUI
import AppIcon

struct InfoScrollContent: View {
    @EnvironmentObject private var settings: UserSettings
    @Environment(\.openURL) private var openURL

    private var settingsURL: URL? {
        URL(string: UIApplication.openSettingsURLString)
    }

    private var appStoreURL: URL? {
        nil // TODO: Add if used in production
    }

    var body: some View {
        LazyVStack(spacing: .vMargin) {
            SwitchListItem(
                isOn: $settings.wordsExpanded,
                title: "words_expanded_title",
                subtitle: "words_expanded_subtitle"
            )
            .button {
                settings.wordsExpanded.toggle()
            }

            TextListItem(
                title: "donate_title",
                subtitle: "donate_subtitle"
            )
            .button {
                // TODO
            }

            if let appStoreURL {
                TextListItem(
                    title: "rate_app_title",
                    subtitle: "rate_app_subtitle"
                )
                .button {
                    openURL(appStoreURL)
                }
            }

            TextListItem(
                title: "report_issue_title",
                subtitle: "report_issue_subtitle"
            )
            .button {
                // TODO
            }

            TextListItem(
                title: "export_title",
                subtitle: "export_subtitle"
            )
            .button {
                // TODO
            }

            if let settingsURL {
                TextListItem(
                    title: "ios_settings_title",
                    subtitle: "ios_settings_subtitle"
                )
                .button {
                    openURL(settingsURL)
                }
            }

            if let appVersion = Bundle.main.appVersion {
                Text("app_version \(appVersion)")
                    .textStyle(.body, fill: .center)
            }
        }
        .padding(.margins)
    }
}

// MARK: - Preview

#Preview {
    ScrollView {
        InfoScrollContent()
    }
    .screen()
    .environmentObjects()
}

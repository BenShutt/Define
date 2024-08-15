//
//  InfoScrollContent.swift
//  Define
//
//  Created by Ben Shutt on 26/06/2024.
//

import SwiftUI
import AppIcon

/// View that is shown in a scroll view of the root screen
struct InfoScreen: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var exportManager = ExportManager()

    var segmentedHeight: CGFloat

    var body: some View {
        RootNavigationScreen(
            segmentedHeight: segmentedHeight,
            subtitle: "info_subtitle \(appNameOrDefault)",
            scrollContent: {
                InfoScrollContentView(onExport: {
                    exportManager.export(modelContext: modelContext)
                })
            }
        )
        .sheet(item: $exportManager.jsonFileURL) { url in
            ShareSheet(items: [url.item]) { _, _, _, _ in
                exportManager.clean(modelContext: modelContext)
            }
        }
    }
}

// MARK: - InfoScrollContentView

private struct InfoScrollContentView: View {
    @EnvironmentObject private var settings: UserSettings
    @Environment(\.openURL) private var openURL

    var onExport: () -> Void

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
            .container()

            TextListItem(
                title: "donate_title",
                subtitle: "donate_subtitle"
            )
            .button {
                // TODO
            }
            .container()

            if let appStoreURL {
                TextListItem(
                    title: "rate_app_title",
                    subtitle: "rate_app_subtitle"
                )
                .button {
                    openURL(appStoreURL)
                }
                .container()
            }

            TextListItem(
                title: "report_issue_title",
                subtitle: "report_issue_subtitle"
            )
            .button {
                // TODO
            }
            .container()

            TextListItem(
                title: "export_title",
                subtitle: "export_subtitle"
            )
            .button(action: onExport)
            .container()

            if let settingsURL {
                TextListItem(
                    title: "ios_settings_title",
                    subtitle: "ios_settings_subtitle"
                )
                .button {
                    openURL(settingsURL)
                }
                .container()
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
        InfoScrollContentView {}
    }
    .screen()
    .environmentObjects()
}

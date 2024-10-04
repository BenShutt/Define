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
            subtitle: "info_subtitle \(appName)",
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
    var onExport: () -> Void

    var body: some View {
        LazyVStack(spacing: .vMargin, pinnedViews: .sectionHeaders) {
            Section(content: {
                SettingsSection()
            }, header: {
                SectionHeader(title: "settings_title")
            })

            Section(content: {
                InfoSection(onExport: onExport)
            }, header: {
                SectionHeader(title: "info_title")
            })
        }
        .padding(.margins)
    }
}

// MARK: - SettingsSection

private struct SettingsSection: View {
    @EnvironmentObject private var settings: UserSettings

    var body: some View {
        SwitchListItem(
            isOn: $settings.wordsExpanded,
            title: "words_expanded_title",
            subtitle: "words_expanded_subtitle"
        )
        .button {
            settings.wordsExpanded.toggle()
        }
        .container()

        SwitchListItem(
            isOn: $settings.wordReminders,
            title: "word_reminders_title",
            subtitle: "word_reminders_subtitle"
        )
        .button {
            settings.wordReminders.toggle()
        }
        .container()
    }
}

// MARK: - InfoSection

private struct InfoSection: View {
    @EnvironmentObject private var settings: UserSettings
    @Environment(\.openURL) private var openURL
    @Environment(\.push) private var push
    var onExport: () -> Void

    var body: some View {
        TextListItem(
            title: "donate_title",
            subtitle: "donate_subtitle"
        )
        .button {
            push(.donate)
        }
        .container()

        if let appStoreURL = URL.appStore {
            TextListItem(
                title: "rate_app_title",
                subtitle: "rate_app_subtitle"
            )
            .button {
                openURL(appStoreURL)
            }
            .container()
        }

        if let reportIssueURL = URL.reportIssue {
            TextListItem(
                title: "report_issue_title",
                subtitle: "report_issue_subtitle"
            )
            .button {
                openURL(reportIssueURL)
            }
            .container()
        }

        TextListItem(
            title: "export_title",
            subtitle: "export_subtitle"
        )
        .button(action: onExport)
        .container()

        if let sourceCodeURL = URL.sourceCode {
            TextListItem(
                title: "source_code_title",
                subtitle: "source_code_subtitle"
            )
            .button {
                openURL(sourceCodeURL)
            }
            .container()
        }

        if let settingsURL = URL.settings {
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
}

// MARK: - Preview

#Preview {
    ScrollView {
        InfoScrollContentView {}
    }
    .screen()
    .environmentObjects()
}

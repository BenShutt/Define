//
//  InfoScreen.swift
//  Define
//
//  Created by Ben Shutt on 26/06/2024.
//

import SwiftUI
import AppIcon

// TODO: Use info page (possibly a tab)

struct InfoScreen: View {
    @EnvironmentObject private var words: WordsViewModel
    @Environment(\.openURL) private var openURL

    private var settingsURL: URL? {
        URL(string: UIApplicationOpenNotificationSettingsURLString)
    }

    private var appStoreURL: URL? {
        nil // TODO
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: .vMargin) {
                ThemeListItem()
                    .button {
                        // TODO
                    }

                SimpleListItem(
                    title: "donate_title",
                    subtitle: "donate_subtitle"
                )
                .button {
                    // TODO
                }

                if let appStoreURL {
                    SimpleListItem(
                        title: "rate_app_title",
                        subtitle: "rate_app_subtitle"
                    )
                    .button {
                        openURL(appStoreURL)
                    }
                }

                SimpleListItem(
                    title: "report_issue_title",
                    subtitle: "report_issue_subtitle"
                )
                .button {
                    // TODO
                }

                SimpleListItem(
                    title: "export_title",
                    subtitle: "export_subtitle"
                )
                .button {
                    // TODO
                }

                if let settingsURL {
                    SimpleListItem(
                        title: "settings_title",
                        subtitle: "settings_subtitle"
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
            .padding(.horizontal, .hMargin)
            .padding(.vertical, .vMargin)
        }
        .screen()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("info_title")
                    .textStyle(.h2)
            }
        }
        .stickyTop {
            HeaderView(spacing: 0, padding: .headerPadding) {}
        }
    }
}

// MARK: - ThemeListItem

struct ThemeListItem: View {
    private let shape = RoundedRectangle(cornerRadius: .cornerRadius)

    var body: some View {
        ListItem(
            title: "theme_title",
            subtitle: "theme_subtitle",
            leading: {
                AppIconGradient(start: 0.25, end: 1)
                    .frame(width: 50, height: 50)
                    .clipShape(shape)
                    .overlay {
                        shape.strokeBorder(
                            Color.appBlue.opacity(0.4),
                            lineWidth: .borderWidth
                        )
                    }
                    .overlay {
                        Text(verbatim: "B") // TODO
                            .textStyle(.h2)
                    }
            }
        )
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        InfoScreen()
    }
    .environmentObject(WordsViewModel())
}

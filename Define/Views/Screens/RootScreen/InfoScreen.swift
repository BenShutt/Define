//
//  InfoScreen.swift
//  Define
//
//  Created by Ben Shutt on 26/06/2024.
//

import SwiftUI
import AppIcon

struct InfoScreen: View {
    @Environment(\.openURL) private var openURL

    private var settingsURL: URL? {
        URL(string: UIApplication.openSettingsURLString)
    }

    private var appStoreURL: URL? {
        nil // TODO: Add if used in production
    }

    var body: some View {
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
        .padding(.margins)
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
    ScrollView {
        InfoScreen()
    }
    .screen()
}

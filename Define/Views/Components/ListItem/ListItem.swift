//
//  ListItem.swift
//  Define
//
//  Created by Ben Shutt on 26/06/2024.
//

import SwiftUI

// MARK: - SwitchListItem

struct SwitchListItem: View {
    @Binding var isOn: Bool
    var title: LocalizedStringResource
    var subtitle: LocalizedStringResource

    var body: some View {
        ListItem(
            title: .init(localized: title),
            subtitle: .init(localized: subtitle),
            leading: {},
            trailing: {
                Toggle(isOn: $isOn) {}
                    .toggleStyle(SwitchToggleStyle(tint: .default))
                    .fixedSize(horizontal: true, vertical: false)
            }
        )
    }
}

// MARK: - TextListItem

struct TextListItem: View {
    var title: LocalizedStringResource
    var subtitle: LocalizedStringResource

    var body: some View {
        ListItem(
            title: .init(localized: title),
            subtitle: .init(localized: subtitle),
            leading: {},
            trailing: {
                ChevronView()
            }
        )
    }
}

// MARK: - ListItem

struct ListItem<Leading: View, Trailing: View>: View {
    var title: String
    var subtitle: String?
    @ViewBuilder var leading: () -> Leading
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        HStack(spacing: .medium) {
            leading()

            VStack(spacing: .small) {
                Text(title)
                    .textStyle(.h4, fill: .leading)

                if let subtitle {
                    Text(subtitle)
                        .textStyle(.body, fill: .leading)
                }
            }

            trailing()
        }
        .padding(.margins)
        .background(Color.appWhite)
    }
}

// MARK: - Preview

#Preview {
    VStack {
        TextListItem(
            title: "rate_app_title",
            subtitle: "rate_app_subtitle"
        )

        SwitchListItem(
            isOn: .constant(false),
            title: "words_expanded_title",
            subtitle: "words_expanded_subtitle"
        )
    }
    .padding(.margins)
    .screen()
}

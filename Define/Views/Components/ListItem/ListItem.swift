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
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    var margins: EdgeInsets = .zero

    var body: some View {
        ListItem(
            title: title,
            subtitle: subtitle,
            margins: margins,
            leading: {},
            trailing: {
                Toggle(isOn: $isOn) {}
                    .toggleStyle(SwitchToggleStyle(tint: .default))
            }
        )
    }
}

// MARK: - TextListItem

struct TextListItem: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    var margins: EdgeInsets = .zero

    var body: some View {
        ListItem(
            title: title,
            subtitle: subtitle,
            margins: margins,
            leading: {},
            trailing: {
                ChevronView()
            }
        )
    }
}

// MARK: - ListItem

struct ListItem<Leading: View, Trailing: View>: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey?
    var margins: EdgeInsets = .zero
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
        .margined(margins)
    }
}

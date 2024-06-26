//
//  ListItem.swift
//  Define
//
//  Created by Ben Shutt on 26/06/2024.
//

import SwiftUI

// MARK: - SimpleListItem

struct SimpleListItem: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    var margins: EdgeInsets = .zero

    var body: some View {
        ListItem(
            title: title,
            subtitle: subtitle,
            margins: margins,
            leading: {}
        )
    }
}

// MARK: - ListItem

struct ListItem<Leading: View>: View {
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey
    var margins: EdgeInsets = .zero
    @ViewBuilder var leading: () -> Leading

    var body: some View {
        HStack(spacing: .medium) {
            leading()

            VStack(spacing: .small) {
                Text(title)
                    .textStyle(.h4, fill: .leading)

                Text(subtitle)
                    .textStyle(.body, fill: .leading)
            }

            ChevronView()
        }
        .padding(.margins)
        .background(Color.appWhite)
        .margined(margins)
    }
}

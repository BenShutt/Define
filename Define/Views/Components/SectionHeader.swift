//
//  SectionHeader.swift
//  Define
//
//  Created by Ben Shutt on 17/08/2024.
//

import SwiftUI

struct SectionHeader: View {
    var title: LocalizedStringKey
    private let separatorColor: Color = .appGray.opacity(0.1)

    var body: some View {
        HStack(spacing: .extraLarge) {
            Separator(color: separatorColor)
                .frame(minWidth: .hMargin, maxWidth: .infinity)

            Text(title)
                .textStyle(.h4)
                .fixedSize(horizontal: true, vertical: true)

            Separator(color: separatorColor)
                .frame(minWidth: .hMargin, maxWidth: .infinity)
        }
        .padding(.horizontal, .hMargin)
        .padding(.vertical, .smallMedium)
        .background(Color.screenBackground)
    }
}

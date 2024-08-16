//
//  InformationSheet.swift
//  Define
//
//  Created by Ben Shutt on 09/10/2023.
//

import SwiftUI

struct InformationSheet: View {
    @Environment(\.dismiss) var dismiss
    var title: LocalizedStringKey
    var subtitle: LocalizedStringKey

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: .medium) {
                Text(title)
                    .textStyle(.h2, fill: .leading)

                CrossButton(action: dismiss.callAsFunction)
            }

            Text(subtitle)
                .textStyle(.body, fill: .leading)
                .padding(.top, .small)
        }
        .padding(.margins)
        .fixedSizeSheet()
    }
}

// MARK: - Preview

#Preview {
    Color.appWhite
        .sheet(isPresented: .constant(true)) {
            InformationSheet(
                title: "reminder_sheet_title \("Word")",
                subtitle: "reminder_sheet_subtitle \("Word") \("1 day")"
            )
        }
}

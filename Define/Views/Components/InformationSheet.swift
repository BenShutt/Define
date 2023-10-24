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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark.app.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(size: 26)
                        .padding(5) // Adding tap area
                        .offset(x: 5) // For padding offset
                        .foregroundStyle(Color.appDarkGray)
                })
                .frame(maxWidth: .infinity, alignment: .trailing)

                Text(title)
                    .h2()
                    .padding(.top, .small)

                Text(subtitle)
                    .body()
                    .padding(.top, .smallMedium)
            }
            .multilineTextAlignment(.leading)
            .padding(.margins)
            .frame(maxWidth: .infinity)
            .padding(.vertical, .small)
        }
        .presentationDetents([.fraction(0.25), .fraction(0.75)])
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

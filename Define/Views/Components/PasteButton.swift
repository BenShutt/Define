//
//  PasteButton.swift
//  Define
//
//  Created by Ben Shutt on 16/08/2024.
//

import SwiftUI

struct PasteButton: View {
    private let color: Color = .default
    private let textStyle: TextStyle = .h3

    var title: LocalizedStringKey
    var action: () -> Void

    var body: some View {
        Button(action: action, label: {
            HStack(spacing: .medium) {
                Image(.paste)
                    .font(textStyle.font)

                Text(title)
                    .foregroundStyle(color)
                    .textStyle(textStyle)
            }
            .frame(maxWidth: .infinity)
            .padding(.margins)
            .foregroundStyle(color)
            .background(color.opacity(0.1))
            .background(Color.appWhite)
        })
    }
}

// MARK: - Preview

#Preview {
    PasteButton(title: "paste_copy") {}
}

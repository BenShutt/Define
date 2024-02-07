//
//  TitleHeaderView.swift
//  Define
//
//  Created by Ben Shutt on 30/10/2023.
//

import SwiftUI

/// Header view with only a title
struct TitleHeaderView: ViewModifier {

    var title: LocalizedStringKey

    private var padding: EdgeInsets {
        var padding: EdgeInsets = .header
        padding.top = .extraSmall
        padding.bottom = .extraSmall
        return padding
    }

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .h2()
                }
            }
            .toolbarBackground(
                RadialGradient(
                    colors: [
                        .appBlue.opacity(0.05),
                        .appBlue.opacity(0.25)
                    ],
                    center: .center,
                    startRadius: 10,
                    endRadius: 40
                 ),
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        Color.clear
            .screen()
            .modifier(TitleHeaderView(title: "Preview Title"))
    }
}

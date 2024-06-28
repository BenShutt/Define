//
//  WordSavedView.swift
//  Define
//
//  Created by Ben Shutt on 28/06/2024.
//

import SwiftUI

struct WordSavedView: View {
    var word: String

    var body: some View {
        Text("word_saved \(word)")
            .textStyle(
                .h4,
                textColor: .appGray,
                fill: .center
            )
            .padding(.margins)
            .background(Color.appLightGray)
    }
}

// MARK: - Preview

#Preview {
    WordSavedView(word: "Preview")
        .screen()
}

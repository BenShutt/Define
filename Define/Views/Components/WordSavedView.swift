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
        VStack(spacing: 0) {
            Text("word_saved \(word)")
                .textStyle(
                    .h4,
                    textColor: .appBlack,
                    fill: .center
                )
                .padding(.margins)
                .background(GradientBlurView(color: .appGreen))

            Separator(color: .appDarkGray.opacity(0.1))
        }
    }
}

// MARK: - Preview

#Preview {
    VStack {
        Color.clear.frame(height: 1)
        WordSavedView(word: "Preview")
        Spacer()
    }
    .screen()
}

//
//  WordSavedView.swift
//  Define
//
//  Created by Ben Shutt on 28/06/2024.
//

import SwiftUI

struct WordSavedView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("word_saved")
                .foregroundStyle(Color.appBlack) // Override
                .textStyle(.h4, fill: .center)
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
        WordSavedView()
        Spacer()
    }
    .screen()
}

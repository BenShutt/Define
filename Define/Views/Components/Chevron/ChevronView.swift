//
//  ChevronView.swift
//  Define
//
//  Created by Ben Shutt on 19/12/2022.
//

import SwiftUI

/// `View` drawing a chevron
struct ChevronView: View {

    var body: some View {
        Chevron()
            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
            .foregroundColor(Color.appDarkGray)
            .frame(width: 6, height: 14)
            .padding(.horizontal, 13)
            .padding(.vertical, 9)
            .background(Color.appLightGray)
            .cornerRadius(.cornerRadius)
    }
}

// MARK: - Preview

#Preview {
    ChevronView()
}

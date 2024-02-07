//
//  NavigationBarBackground.swift
//  NavigationBar
//
//  Created by Ben Shutt on 31/10/2023.
//

import SwiftUI

/// Background view of the navigation bar
struct NavigationBarBackground: View {

    var body: some View {
        LinearGradient(
            colors: [
                .appBlue.opacity(0.1),
                .appBlue.opacity(0.3)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .background(Color.appWhite)
        .compositingGroup()
        .shadow(.sticky)
    }
}

// MARK: - Preview

#Preview {
    NavigationBarBackground()
}

//
//  Screen.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import SwiftUI

/// Base screen UI
struct ScreenBody<Content: View>: View {

    /// Background color
    var backgroundColor: Color

    /// Screen content view
    @ViewBuilder var content: () -> Content

    /// Draw base screen body
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 0) {
                content()
                Spacer(minLength: 0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Screen

/// An app screen
struct Screen: ViewModifier {

    var backgroundColor: Color

    func body(content: Content) -> some View {
        ScreenBody(backgroundColor: backgroundColor) { content }
    }
}

// MARK: - View + Screen

extension View {

    func screen(backgroundColor: Color = .appLightGray) -> some View {
        modifier(Screen(backgroundColor: backgroundColor))
    }
}

// MARK: - Preview

#Preview {
    ScreenBody(backgroundColor: .appBlack.opacity(0.4)) {}
}

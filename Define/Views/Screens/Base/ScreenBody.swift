//
//  ScreenBody.swift
//  Define
//
//  Created by Ben Shutt on 04/01/2023.
//

import SwiftUI

/// Base screen UI
struct ScreenBody<Content: View>: View {

    /// Background color
    var backgroundColor: Color = .appLightGray

    /// Screen content view
    @ViewBuilder var content: () -> Content

    /// Draw base screen body
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            content()
        }
    }
}

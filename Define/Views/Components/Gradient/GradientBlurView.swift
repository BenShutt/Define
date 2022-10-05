//
//  GradientBlurView.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI

struct GradientBlurView: View {

    var colors: [Color] {
        [Color.appWhite, .appLightBlue].map { $0.opacity(0.1) }
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
            BlurView(style: .light)
        }
        .ignoresSafeArea()
    }
}

// MARK: - PreviewProvider

struct GradientBlurView_Previews: PreviewProvider {
    static var previews: some View {
        GradientBlurView()
    }
}

//
//  GradientBlurView.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI

struct GradientBlurView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.appDarkBlue, .appBlue],
                startPoint: .top,
                endPoint: .bottom
            )
            BlurView(style: .prominent)
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

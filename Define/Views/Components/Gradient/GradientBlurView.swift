//
//  GradientBlurView.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI

/// Blurred linear gradient
struct GradientBlurView: View {

    /// Draw `View`
    var body: some View {
        ZStack {
            LinearGradient.header
            BlurView(style: .light)
        }
    }
}

// MARK: - PreviewProvider

struct GradientBlurView_Previews: PreviewProvider {

    static var previews: some View {
        GradientBlurView()
    }
}

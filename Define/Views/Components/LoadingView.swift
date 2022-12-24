//
//  LoadingView.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// Default loading UI which fills the bound of its space
struct LoadingView: View {

    /// `Color` of indicator
    var color = Color.appDarkBlue

    /// When `true`, set maxWidth and minWidth of the frame to `.infinity`
    var infiniteFrame = false

    /// Customize a `ProgressView`
    var body: some View {
        ProgressView()
            .tint(color)
            .progressViewStyle(CircularProgressViewStyle())
            .if(infiniteFrame) {
                $0.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
    }
}

// MARK: - PreviewProvider

struct LoadingView_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            Color.appWhite
                .ignoresSafeArea()
            LoadingView()
        }
    }
}

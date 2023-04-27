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

    /// Customize a `ProgressView`
    var body: some View {
        ProgressView()
            .tint(color)
            .progressViewStyle(CircularProgressViewStyle())
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

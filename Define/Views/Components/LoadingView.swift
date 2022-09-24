//
//  LoadingView.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// Default loading UI which fills the bound of its space
struct LoadingView: View {

    /// Customize a `ProgressView`
    var body: some View {
        ProgressView()
            .scaleEffect(2, anchor: .center)
            .tint(.appGray)
            .progressViewStyle(CircularProgressViewStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - PreviewProvider

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.appWhite.ignoresSafeArea()
            LoadingView()
        }
    }
}

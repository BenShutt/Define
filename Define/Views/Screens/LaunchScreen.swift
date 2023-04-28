//
//  LaunchScreen.swift
//  Define
//
//  Created by Ben Shutt on 07/10/2022.
//

import SwiftUI

/// Screen that shows while the app is launching
struct LaunchScreen: Screen {

    /// Size of the container
    var containerSize: CGFloat = 200

    /// Size of the padding
    var padding: CGFloat = 40

    /// Draw `View`
    var screen: some View {
        LogoView(showBorder: true)
            .frame(size: containerSize - 2 * padding)
            .padding(padding)
    }
}

// MARK: - PreviewProvider

struct LaunchScreen_Previews: PreviewProvider {

    static var previews: some View {
        LaunchScreen()
    }
}

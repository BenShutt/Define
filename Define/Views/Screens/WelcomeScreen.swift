//
//  WelcomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 23/08/2023.
//

import SwiftUI

struct WelcomeScreen: Screen {

    private var appName: String? {
        Bundle.main.appName
    }

    var screen: some View {
        if let appName {
            Text(verbatim: .WelcomeScreen.title(appName: appName))
                .h1()
        }
    }
}

// MARK: - PreviewProvider

struct WelcomeScreen_Previews: PreviewProvider {

    static var previews: some View {
        WelcomeScreen()
    }
}

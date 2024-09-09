//
//  NavigationBarAppearance.swift
//  Define
//
//  Created by Ben Shutt on 30/06/2024.
//

import SwiftUI

@MainActor
struct NavigationAppearance {
    var backgroundColor: Color = .clear

    static func setup() {
        NavigationAppearance().setup()
    }

    func setup() {
        // UINavigationBarAppearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(backgroundColor)

        // UINavigationBar
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
}

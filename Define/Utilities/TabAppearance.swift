//
//  TabAppearance.swift
//  Define
//
//  Created by Ben Shutt on 27/06/2024.
//

import SwiftUI

struct TabAppearance {
    var selectedForegroundColor: Color = .appBlue
    var foregroundColor: Color = .appGray.opacity(0.75)
    var backgroundColor: Color = .appWhite
    var textStyle: TextStyle = .h4

    static func setup() {
        TabAppearance().setup()
    }

    func setup() {
        // UITabBarItemAppearance
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = UIColor(foregroundColor)
        tabBarItemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(foregroundColor)
        ]
        tabBarItemAppearance.selected.iconColor = UIColor(selectedForegroundColor)
        tabBarItemAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(selectedForegroundColor)
        ]

        // UITabBarAppearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(backgroundColor)
        tabBarAppearance.selectionIndicatorTintColor = UIColor(selectedForegroundColor)
        tabBarAppearance.stackedItemPositioning = .automatic
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance

        // UITabBar
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        // UITabBarItem
        guard let font = textStyle.uiFont else { return }
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: font],
            for: .normal
        )
    }
}

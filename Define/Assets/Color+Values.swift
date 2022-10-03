//
//  Color+Values.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// Set of `Color`s used in this app
extension Color {
    static let appBlack = Color("appBlack")
    static let appBlue = Color("appBlue")
    static let appBrown = Color("appBrown")
    static let appDarkBlue = Color("appDarkBlue")
    static let appFaintGray = Color("appFaintGray")
    static let appGray = Color("appGray")
    static let appGreen = Color("appGreen")
    static let appLightGray = Color("appLightGray")
    static let appPurple = Color("appPurple")
    static let appWhite = Color("appWhite")
}

// MARK: - [Color] + Values

extension Array where Element == Color {
    static let blue: [Color] = [.appBlue, .appDarkBlue]
}

// MARK: - Gradient + Values

extension Gradient {
    static let blue = Gradient(colors: .blue)
}

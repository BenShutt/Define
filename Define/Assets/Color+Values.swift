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
    static let appDarkBlue = Color("appDarkBlue")
    static let appBlue = Color("appBlue")
    static let appDarkGray = Color("appDarkGray")
    static let appLightBlue = Color("appLightBlue")
    static let appLightGray = Color("appLightGray")
    static let appLightOrange = Color("appLightOrange")
    static let appLightRed = Color("appLightRed")
    static let appShadow = Color("appShadow")
    static let appWhite = Color("appWhite")

    // MARK: - Computed

    static var appPrimary: Color {
        appDarkBlue
    }

    static var appAccent: Color {
        appLightBlue
    }
}

// MARK: - [Color] + Values

extension Array where Element == Color {

    static let appBlue: [Color] = [.appBlue, .appDarkBlue]
}

// MARK: - Gradient + Values

extension Gradient {

    static let blue = Gradient(colors: .appBlue)
}

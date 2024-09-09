//
//  CGFloat+Values.swift
//  AppIconGenerator
//
//  Created by Ben Shutt on 27/06/2024.
//

import Foundation

typealias Pixels = CGFloat
typealias Points = CGFloat

extension CGFloat {
    static let appIconSize: Pixels = 1024
    static let launchScreenWidth: Pixels = iPhone15ProMaxWidth * 3
    static let launchScreenHeight: Pixels = iPhone15ProMaxHeight * 3

    static let iPhone15ProMaxWidth: Points = 430
    static let iPhone15ProMaxHeight: Points = 932
}

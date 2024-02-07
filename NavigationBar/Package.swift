// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NavigationBar",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "NavigationBar",
            targets: ["NavigationBar"]
        )
    ],
    targets: [
        .target(
            name: "NavigationBar",
            path: "Sources"
        )
    ]
)

// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppIcon",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "AppIcon",
            targets: ["AppIcon"]
        ),
        .executable(
            name: "AppIconGenerator",
            targets: ["AppIconGenerator"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMajor(from: "1.0.0")
        ),
        .package(
            url: "https://github.com/BenShutt/Utilities.git",
            branch: "develop"
        )
    ],
    targets: [
        .target(
            name: "AppIcon",
            dependencies: [
                .product(name: "ColorUtilities", package: "Utilities"),
                .product(name: "Utilities", package: "Utilities")
            ],
            path: "AppIcon"
        ),
        .executableTarget(
            name: "AppIconGenerator",
            dependencies: [
                "AppIcon",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Utilities", package: "Utilities"),
                .product(name: "ViewRenderer", package: "Utilities")
            ],
            path: "AppIconGenerator"
        )
    ]
)

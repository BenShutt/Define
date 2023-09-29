// swift-tools-version: 5.9
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
        )
    ],
    targets: [
        .target(
            name: "AppIcon",
            path: "AppIcon"
        ),
        .executableTarget(
            name: "AppIconGenerator",
            dependencies: [
                "AppIcon",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "AppIconGenerator"
        )
    ]
)

// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DictionaryAPI",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "DictionaryAPI",
            targets: ["DictionaryAPI"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/BenShutt/DataRequest.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/BenShutt/Utilities.git",
            branch: "develop"
        )
    ],
    targets: [
        .target(
            name: "DictionaryAPI",
            dependencies: ["DataRequest", "Utilities"],
            path: "Sources"
        ),
        .testTarget(
            name: "DictionaryAPITests",
            dependencies: ["DictionaryAPI"],
            path: "Tests"
        )
    ]
)

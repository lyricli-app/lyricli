// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "lyricli",
    dependencies: [
        /// 🔡 Tools for working with HTML entities
        .package(url: "https://github.com/IBM-Swift/swift-html-entities.git", from: "3.0.11"),

        /// 🚩 Command Line Arguments
        .package(url: "https://github.com/Subito-it/Bariloche", from: "1.0.4")
    ],
    targets: [
        .target(
            name: "lyricli",
            dependencies: ["HTMLEntities", "Bariloche"]),
        .testTarget(
            name: "lyricliTests",
            dependencies: ["lyricli"]),
    ]
)

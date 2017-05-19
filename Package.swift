import PackageDescription

let package = Package(
    name: "lyricli",
    dependencies: [
        .Package(url: "https://github.com/rbdr/CommandLineKit", majorVersion: 4, minor: 0),
        .Package(url: "https://github.com/IBM-Swift/swift-html-entities.git", majorVersion: 3, minor: 0)
    ]
)

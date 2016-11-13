import PackageDescription

let package = Package(
    name: "lyricli",
    dependencies: [
        .Package(url: "https://github.com/rbdr/CommandLineKit", majorVersion: 4, minor: 0),
    ]
)

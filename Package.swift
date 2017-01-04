import PackageDescription

let package = Package(
    name: "Flash",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1)
    ]
)

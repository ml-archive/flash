import PackageDescription

let package = Package(
    name: "Flash",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/auth-provider.git", Version(1,0,0, prereleaseIdentifiers: ["beta"]))
    ]
)

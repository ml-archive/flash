// swift-tools-version:4.1
import PackageDescription

let package = Package(
    name: "Flash",
    products: [
        .library(name: "Flash", targets: ["Flash"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "Flash", dependencies: ["Leaf", "Vapor"]),
        .testTarget(name: "FlashTests", dependencies: ["Flash"]),
    ]
)

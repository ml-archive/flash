// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Flash",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Flash", targets: ["Flash"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc"),
    ],
    targets: [
        .target(name: "Flash", dependencies: [
            .product(name: "Leaf", package: "leaf"),
            .product(name: "Vapor", package: "vapor"),
        ]),
        .testTarget(name: "FlashTests", dependencies: ["Flash"]),
    ]
)

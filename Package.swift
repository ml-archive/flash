// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Flash",
    products: [
        .library(name: "Flash", targets: ["Flash"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nodes-vapor/sugar.git", from: "3.0.0-beta"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc"),
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "Flash", dependencies: ["Leaf", "Sugar", "Vapor"]),
        .testTarget(name: "FlashTests", dependencies: ["Flash"]),
    ]
)

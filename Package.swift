// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "SDK",
            targets: ["SDK"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SDK",
            dependencies: []
        ),
        .testTarget(
            name: "SDKTests",
            dependencies: ["SDK"]),
    ]
)

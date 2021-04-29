// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Commons",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Commons",
            targets: ["Commons"]),
    ],
    dependencies: [
        .package(url: "https://github.com/luanachen/NetworkHelper", from: "1.4.2")
    ],
    targets: [
        .target(
            name: "Commons",
            dependencies: ["NetworkHelper"]),
        .testTarget(
            name: "CommonsTests",
            dependencies: ["Commons"]),
    ]
)

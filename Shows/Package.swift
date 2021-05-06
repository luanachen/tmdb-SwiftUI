// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shows",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Shows",
            targets: ["Shows"]),
    ],
    dependencies: [
        .package(path: "../Commons"),
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.9.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Shows",
            dependencies: ["Commons"]),
        .testTarget(
            name: "ShowsTests",
            dependencies: ["Shows", "Commons", "SnapshotTesting"],
            resources: [
                .process("Responses/popularTV.json"),
                .process("Responses/showCredits.json"),
                .process("Responses/showDetail.json"),
                .copy("Views/__Snapshots__/"),
            ]),
    ]
)

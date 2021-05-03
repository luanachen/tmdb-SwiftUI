// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Login",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Login",
            targets: ["Login"]),
    ],
    dependencies: [
        .package(path: "../Commons"),
        .package(name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.9.0")

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Login",
            dependencies: ["Commons"]),
        .testTarget(
            name: "LoginTests",
            dependencies: ["Login", "Commons", "SnapshotTesting"],
            resources: [
                .process("Responses/createSession.json"),
                .process("Responses/requestToken.json"),
                .process("Views/__Snapshots__/LoginViewTests/test_snapshot.1.png")
            ]),
    ]
)

// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppCoreUI",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppCoreUI",
            targets: ["AppCoreUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AppCoreUI",
            dependencies: [],
            path: "Sources",
            resources: [.process("Resources")]),
        .testTarget(
            name: "AppCoreUITests",
            dependencies: ["AppCoreUI"]),
    ]
)

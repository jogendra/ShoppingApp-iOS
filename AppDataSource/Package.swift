// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppDataSource",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppDataSource",
            targets: ["AppDataSource"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AppDataSource",
            dependencies: [],
            path: "Sources",
            resources: [.process("Resources")]),
        .testTarget(
            name: "AppDataSourceTests",
            dependencies: ["AppDataSource"]),
    ]
)

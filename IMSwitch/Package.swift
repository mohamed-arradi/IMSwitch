// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IMSwitch",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "IMSwitch",
            targets: ["IMSwitch"]),
    ],
    targets: [
        .target(
            name: "IMSwitch"),
        .testTarget(
            name: "IMSwitchTests",
            dependencies: ["IMSwitch"]),
    ]
)

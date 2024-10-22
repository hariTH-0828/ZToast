// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZToast",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ZToast",
            targets: ["ZToast"]),
    ],
    targets: [
        .target(
            name: "ZToast"),
        .testTarget(
            name: "ZToastTests",
            dependencies: ["ZToast"]),
    ]
)

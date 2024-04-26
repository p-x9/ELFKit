// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ELFKit",
    products: [
        .library(
            name: "ELFKit",
            targets: ["ELFKit"]
        ),
    ],
    targets: [
        .target(
            name: "ELFKit"
        ),
        .testTarget(
            name: "ELFKitTests",
            dependencies: ["ELFKit"]
        ),
    ]
)

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
    dependencies: [
        .package(url: "https://github.com/p-x9/swift-fileio.git", from: "0.9.0")
    ],
    targets: [
        .target(
            name: "ELFKit",
            dependencies: [
                "ELFKitC",
                .product(name: "FileIO", package: "swift-fileio")
            ]
        ),
        .target(
            name: "ELFKitC"
        ),
        .testTarget(
            name: "ELFKitTests",
            dependencies: ["ELFKit"]
        ),
    ]
)

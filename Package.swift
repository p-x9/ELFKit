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
        .package(
            url: "https://github.com/p-x9/swift-binary-parse-support.git",
            from: "0.2.1"
        ),
        .package(
            url: "https://github.com/p-x9/swift-fileio.git",
            from: "0.9.0"
        ),
        .package(
            url: "https://github.com/p-x9/swift-fileio-extra.git",
            from: "0.2.2"
        ),
    ],
    targets: [
        .target(
            name: "ELFKit",
            dependencies: [
                "ELFKitC",
                .product(name: "BinaryParseSupport", package: "swift-binary-parse-support"),
                .product(name: "FileIO", package: "swift-fileio"),
                .product(name: "FileIOBinary", package: "swift-fileio-extra")
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

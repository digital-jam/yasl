// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "YASL",
    products: [
        .library(
            name: "YASL",
            targets: ["YASL"]),
    ],
    targets: [
        .target(
            name: "YASL",
            dependencies: []),
        .testTarget(
            name: "YASLTests",
            dependencies: ["YASL"]),
    ]
)

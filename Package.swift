// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "VisionrangerSDK",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "VisionrangerSDK",
            targets: ["VisionrangerSDK"]
        ),
    ],
    targets: [
        .target(
            name: "VisionrangerSDK",
            dependencies: [],
            path: "VisionrangerSDK"
        ),
        .testTarget(
            name: "VisionrangerTests",
            dependencies: ["VisionrangerSDK"],
            path: "VisionrangerTests"
        ),
    ]
)

// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Visionranger",
    defaultLocalization: "en",
    products: [
        .library(
            name: "Visionranger",
            targets: ["Visionranger"]
        ),
    ],
    targets: [
        .target(
            name: "Visionranger",
            dependencies: [],
            path: "Visionranger"
        ),
        .testTarget(
            name: "VisionrangerTests",
            dependencies: ["Visionranger"],
            path: "VisionrangerTests"
        ),
    ]
)

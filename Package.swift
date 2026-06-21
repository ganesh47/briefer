// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Briefer",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "LearningCore", targets: ["LearningCore"])
    ],
    targets: [
        .target(name: "LearningCore"),
        .testTarget(
            name: "LearningCoreTests",
            dependencies: ["LearningCore"]
        )
    ]
)

// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Briefer",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "LearningCore", targets: ["LearningCore"]),
        .library(name: "BrieferFeatures", targets: ["BrieferFeatures"])
    ],
    targets: [
        .target(name: "LearningCore"),
        .target(
            name: "BrieferFeatures",
            dependencies: ["LearningCore"]
        ),
        .testTarget(
            name: "LearningCoreTests",
            dependencies: ["LearningCore"]
        ),
        .testTarget(
            name: "BrieferFeaturesTests",
            dependencies: ["BrieferFeatures"]
        )
    ]
)

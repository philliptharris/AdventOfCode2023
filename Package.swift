// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AdventOfCode2023",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "AdventOfCode2023", targets: ["AdventOfCode2023"])
    ],
    targets: [
        .target(name: "AdventOfCode2023"),
        .testTarget(name: "AdventOfCode2023Tests", dependencies: ["AdventOfCode2023"])
    ]
)

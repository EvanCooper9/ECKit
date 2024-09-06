// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ECKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "ECKit", targets: ["ECKit"])
    ],
    dependencies: [
        // ECKit
        .package(url: "https://github.com/CombineCommunity/CombineExt", from: "1.0.0"),
        .package(url: "https://github.com/EvanCooper9/SwiftUIX", branch: "master"),
    ],
    targets: [
        .target(
            name: "ECKit",
            dependencies: [
                "CombineExt",
                "SwiftUIX",
            ],
            exclude: [
                "swiftgen.yml",
                "SwiftGen/Templates"
            ]
        ),
        .testTarget(
            name: "ECKitTests",
            dependencies: ["ECKit"]
        )
    ]
)

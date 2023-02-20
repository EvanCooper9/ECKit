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
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.0.0"),
        .package(url: "https://github.com/SwiftUIX/SwiftUIX", branch: "master"),
    ],
    targets: [
        .target(
            name: "ECKit",
            dependencies: [
                "CombineExt",
                "KeychainAccess",
                "SwiftUIX"
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

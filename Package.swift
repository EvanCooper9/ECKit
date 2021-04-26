// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ECKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "ECKit+Core", targets: ["ECKit+Core"]),
        .library(name: "ECKit+Rx", targets: ["ECKit+Rx"]),
        .library(name: "ECKit+UI", targets: ["ECKit+UI"])
    ],
    dependencies: [
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "ECKit+Core",
            dependencies: [],
            path: "ECKit/Core"
        ),
        .target(
            name: "ECKit+Rx",
            dependencies: [
                "RxDataSources",
                .product(name: "Differentiator", package: "RxDataSources")
            ],
            path: "ECKit/Rx"
        ),
        .target(
            name: "ECKit+UI",
            dependencies: ["ECKit+Core"],
            path: "ECKit/UI"
        )
    ]
)

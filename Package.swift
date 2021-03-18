// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ECKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "ECKit", targets: ["ECKit"]),
        .library(name: "ECKit+Rx", targets: ["ECKit+Rx"])
    ],
    dependencies: [
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        .target(
            name: "ECKit",
            dependencies: [],
            path: "ECKit/Core"
        ),
        .target(
            name: "ECKit+Rx",
            dependencies: ["RxDataSources"],
            path: "ECKit/Rx"
        )
    ]
)

// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ECKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "ECKit", targets: ["ECKit"]),
        .library(name: "ECKit+Firebase", targets: ["ECKit+Firebase"])
    ],
    dependencies: [
        // ECKit
        .package(url: "https://github.com/CombineCommunity/CombineExt", from: "1.0.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.0.0"),
        .package(url: "https://github.com/hmlongco/Factory", from: "1.0.0"),
        .package(url: "https://github.com/SwiftUIX/SwiftUIX", branch: "master"),

        // ECKit+Firebase
        .package(url: "https://github.com/akaffenberger/firebase-ios-sdk-xcframeworks", from: "10.0.0"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "ECKit",
            dependencies: [
                "CombineExt",
                "Factory",
                "KeychainAccess",
                "SwiftUIX"
            ],
            exclude: [
                "swiftgen.yml",
                "SwiftGen/Templates"
            ]
        ),
        .target(
            name: "ECKit+Firebase",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                "ECKit",
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk-xcframeworks"),
                .product(name: "FirebaseFunctions", package: "firebase-ios-sdk-xcframeworks"),
                "SwiftUIX"
            ]
        )
    ]
)

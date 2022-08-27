// swift-tools-version: 5.6

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
        .package(url: "git@github.com:CombineCommunity/CombineExt.git", from: "1.0.0"),
        .package(url: "git@github.com:kishikawakatsumi/KeychainAccess.git", from: "4.0.0"),
        .package(url: "git@github.com:hmlongco/Resolver.git", from: "1.0.0"),
        .package(url: "git@github.com:hatchcredit/ResolverAutoregistration.git", from: "1.0.0"),
        .package(url: "git@github.com:SwiftUIX/SwiftUIX.git", branch: "master"),

        // ECKit+Firebase
        .package(url: "git@github.com:firebase/firebase-ios-sdk.git", from: "9.0.0"),
        .package(url: "git@github.com:apple/swift-algorithms.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "ECKit",
            dependencies: [
                "CombineExt",
                "KeychainAccess",
                "Resolver",
                "ResolverAutoregistration",
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
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                "SwiftUIX"
            ]
        )
    ]
)

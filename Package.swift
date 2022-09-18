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
        .package(url: "git@github.com:CombineCommunity/CombineExt", from: "1.0.0"),
        .package(url: "git@github.com:kishikawakatsumi/KeychainAccess", from: "4.0.0"),
        .package(url: "git@github.com:hmlongco/Resolver", from: "1.0.0"),
        .package(url: "git@github.com:hatchcredit/ResolverAutoregistration", from: "1.0.0"),
        .package(url: "git@github.com:SwiftUIX/SwiftUIX", branch: "master"),

        // ECKit+Firebase
        .package(url: "git@github.com:alickbass/CodableFirebase", from: "0.2.0"),
        .package(url: "git@github.com:firebase/firebase-ios-sdk", from: "9.0.0"),
        .package(url: "git@github.com:apple/swift-algorithms", from: "1.0.0")
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
                "CodableFirebase",
                "ECKit",
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                "SwiftUIX"
            ]
        )
    ]
)

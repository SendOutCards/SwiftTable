// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "SwiftTable",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "SwiftTable", targets: ["SwiftTable"]),
    ],
    dependencies: [
        .package(url: "https://github.com/paulofaria/OrderedObjectSet.git", .upToNextMajor(from: "6.0.0")),
    ],
    targets: [
        .target(name: "SwiftTable", dependencies: ["OrderedObjectSet"]),
        .testTarget(name: "SwiftTableTests", dependencies: ["SwiftTable"]),
    ]
)

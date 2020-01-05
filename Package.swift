// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "HTTP",
    products: [
        .library(name: "HTTP", targets: ["HTTP"]),
    ],
    dependencies: [
        .package(path: "../Log"),
        .package(path: "../AIO"),
        .package(path: "../Stream"),
        .package(path: "../JSON"),
        .package(path: "../Compression"),
        .package(path: "../Test"),
        .package(path: "../Fiber")
    ],
    targets: [
        .target(
            name: "HTTP",
            dependencies: [
                "Log", "Network", "Stream", "JSON", "Compression"
            ]),
        .testTarget(
            name: "MessageTests",
            dependencies: ["HTTP", "Test"]),
        .testTarget(
            name: "ServerTests",
            dependencies: ["HTTP", "Test", "Fiber"]),
        .testTarget(
            name: "ClientTests",
            dependencies: ["HTTP", "Test", "Fiber"]),
        .testTarget(
            name: "FunctionalTests",
            dependencies: ["HTTP", "Test", "Fiber"]),
        .testTarget(
            name: "KeyValueCodableTests",
            dependencies: ["HTTP", "Test"]),
    ]
)

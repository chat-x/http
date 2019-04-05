// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "HTTP",
    products: [
        .library(name: "HTTP", targets: ["HTTP"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/tris-code/log.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/aio.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/stream.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/json.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/compression.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/test.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-code/fiber.git",
            .branch("master"))
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

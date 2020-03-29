// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "HTTP",
    products: [
        .library(name: "HTTP", targets: ["HTTP"]),
    ],
    dependencies: [
        .package(path: "../log"),
        .package(path: "../aio"),
        .package(path: "../stream"),
        .package(path: "../json"),
        .package(path: "../test"),
        .package(path: "../fiber")
    ],
    targets: [
        .target(
            name: "HTTP",
            dependencies: ["Log", "Network", "Stream", "JSON"]),
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

#if os(Linux)
package.dependencies.append(.package(path: "../compression"))
package.targets[0].dependencies.append("Compression")
#endif

// swift-tools-version:4.0
/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import PackageDescription

let package = Package(
    name: "HTTP",
    products: [
        .library(name: "HTTP", targets: ["HTTP"]),
        .library(name: "Server", targets: ["Server"]),
        .library(name: "Client", targets: ["Client"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tris-foundation/log.git",
            from: "0.4.0"),
        .package(
            url: "https://github.com/tris-foundation/async.git",
            from: "0.4.0"),
        .package(
            url: "https://github.com/tris-foundation/memory.git",
            from: "0.4.0"),
        .package(
            url: "https://github.com/tris-foundation/network.git",
            from: "0.4.0"),
        .package(
            url: "https://github.com/tris-foundation/json.git",
            from: "0.4.0"),
        .package(
            url: "https://github.com/tris-foundation/fiber.git",
            from: "0.4.0"),
        .package(
            url: "https://github.com/tris-foundation/test.git",
            from: "0.4.0")
    ],
    targets: [
        .target(name: "KeyValueCodable"),
        .target(
            name: "HTTP",
            dependencies: [
                "MemoryStream", "Buffer", "JSON", "KeyValueCodable"
            ]),
        .target(
            name: "Server",
            dependencies: ["Log", "Async", "Network", "HTTP"]
        ),
        .target(
            name: "Client",
            dependencies: ["Log", "Async", "Network", "HTTP"]
        ),
        .testTarget(name: "HTTPTests", dependencies: ["HTTP", "Test"]),
        .testTarget(
            name: "ServerTests",
            dependencies: ["Server", "Test", "AsyncDispatch"]),
        .testTarget(
            name: "ClientTests",
            dependencies: ["Client", "Test", "AsyncDispatch"]),
        .testTarget(
            name: "FunctionalTests",
            dependencies: ["Server", "Client", "Test", "AsyncDispatch"]),
        .testTarget(
            name: "KeyValueCodableTests",
            dependencies: ["KeyValueCodable", "Test"])
    ]
)

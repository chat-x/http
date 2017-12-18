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
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/async.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/stream.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/network.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/json.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/compression.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/test.git",
            .branch("master"))
    ],
    targets: [
        .target(
            name: "KeyValueCodable"),
        .target(
            name: "HTTP",
            dependencies: ["Stream", "JSON", "KeyValueCodable", "Network"]),
        .target(
            name: "Server",
            dependencies: ["Log", "Async", "Network", "HTTP"]),
        .target(
            name: "Client",
            dependencies: ["Log", "Async", "Network", "HTTP", "Compression"]),
        .testTarget(
            name: "HTTPTests",
            dependencies: ["HTTP", "Test"]),
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

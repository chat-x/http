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
            name: "HTTP",
            dependencies: [
                "Log", "Network", "Stream", "JSON", "Compression"
            ]),
        .testTarget(
            name: "MessageTests",
            dependencies: ["HTTP", "Test"]),
        .testTarget(
            name: "ServerTests",
            dependencies: ["HTTP", "Test", "AsyncDispatch"]),
        .testTarget(
            name: "ClientTests",
            dependencies: ["HTTP", "Test", "AsyncDispatch"]),
        .testTarget(
            name: "FunctionalTests",
            dependencies: ["HTTP", "Test", "AsyncDispatch"]),
        .testTarget(
            name: "KeyValueCodableTests",
            dependencies: ["HTTP", "Test"]),
    ]
)

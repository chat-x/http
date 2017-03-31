/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

extension Response {
    public enum ContentType {
        case text
        case html
        case stream
        case json
    }
}

extension Response.ContentType {
    private struct StatusCodeMapping {
        static let text = ASCII("text/plain")
        static let html = ASCII("text/html")
        static let stream = ASCII("aplication/stream")
        static let json = ASCII("application/json")
    }

    var bytes: [UInt8] {
        switch self {
        case .text: return StatusCodeMapping.text
        case .html: return StatusCodeMapping.html
        case .stream: return StatusCodeMapping.stream
        case .json: return StatusCodeMapping.json
        }
    }
}

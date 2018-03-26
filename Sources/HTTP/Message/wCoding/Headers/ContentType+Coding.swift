/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Stream

extension ContentType {
    private struct Bytes {
        static let charset = ASCII("charset=")
    }

    init<T: StreamReader>(from stream: T) throws {
        self.mediaType = try MediaType(from: stream)

        switch self.mediaType {
        case .multipart:
            guard try stream.consume(.semicolon) else {
                throw ParseError.invalidContentTypeHeader
            }
            try stream.consume(while: { $0 == .whitespace })

            self.charset = nil
            self.boundary = try Boundary(from: stream)

        default:
            guard try stream.consume(.semicolon) else {
                self.charset = nil
                self.boundary = nil
                break
            }
            try stream.consume(while: { $0 == .whitespace })

            // FIXME: validate with value-specific rule
            guard try stream.consume(sequence: Bytes.charset) else {
                throw ParseError.invalidContentTypeHeader
            }
            self.charset = try Charset(from: stream)
            self.boundary = nil
        }
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        try mediaType.encode(to: stream)
        if let charset = charset {
            try charset.encode(to: stream)
        }
    }
}

extension Boundary {
    private struct Bytes {
        static let boundary = ASCII("boundary=")
    }

    init<T: StreamReader>(from stream: T) throws {
        guard try stream.consume(sequence: Bytes.boundary) else {
            throw ParseError.invalidBoundary
        }
        // FIXME: validate with value-specific rule
        self = try Boundary(try stream.read(allowedBytes: .text))
    }
}

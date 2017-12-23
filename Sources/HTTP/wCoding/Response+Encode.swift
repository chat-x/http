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
import Network

extension Response {
    @_specialize(exported: true, where T == BufferedOutputStream<NetworkStream>)
    public func encode<T: UnsafeStreamWriter>(to stream: T) throws {
        // Start line
        try version.encode(to: stream)
        try stream.write(.whitespace)
        try status.encode(to: stream)
        try stream.write(Constants.lineEnd)

        // Headers
        @inline(__always)
        func writeHeader(
            _ name: HeaderName,
            encoder: (T) throws -> Void
        ) throws {
            try stream.write(name.bytes)
            try stream.write(.colon)
            try stream.write(.whitespace)
            try encoder(stream)
            try stream.write(Constants.lineEnd)
        }

        @inline(__always)
        func writeHeader(_ name: HeaderName, value: String) throws {
            try writeHeader(name) { stream in
                try stream.write(value)
            }
        }

        if let contentType = self.contentType {
            try writeHeader(.contentType, encoder: contentType.encode)
        }

        if let contentLength = self.contentLength {
            try writeHeader(.contentLength, value: String(contentLength))
        }

        if let connection = self.connection {
            try writeHeader(.connection, encoder: connection.encode)
        }

        if let contentEncoding = self.contentEncoding {
            try writeHeader(.contentEncoding, encoder: contentEncoding.encode)
        }

        if let transferEncoding = self.transferEncoding {
            try writeHeader(.transferEncoding, encoder: transferEncoding.encode)
        }

        for cookie in self.setCookie {
            try writeHeader(.setCookie, encoder: cookie.encode)
        }

        for (key, value) in headers {
            try writeHeader(key, value: value)
        }

        // Separator
        guard try stream.write(Constants.lineEnd) ==
            Constants.lineEnd.count else {
                throw StreamError.notEnoughSpace
        }

        // Body
        if let rawBody = rawBody {
            guard try stream.write(rawBody) == rawBody.count else {
                throw StreamError.notEnoughSpace
            }
        }
    }
}
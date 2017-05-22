/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

extension Request {
    public struct HeaderNames {
        static let host = HeaderName("Host")
        static let userAgent = HeaderName("User-Agent")
        static let accept = HeaderName("Accept")
        static let acceptLanguage = HeaderName("Accept-Language")
        static let acceptEncoding = HeaderName("Accept-Encoding")
        static let acceptCharset = HeaderName("Accept-Charset")
        static let keepAlive = HeaderName("Keep-Alive")
        static let connection = HeaderName("Connection")
        static let contentLength = HeaderName("Content-Length")
        static let contentType = HeaderName("Content-Type")
        static let transferEncoding = HeaderName("Transfer-Encoding")
    }
}

extension Response {
    public struct HeaderNames {
        static let connection = HeaderName("Connection")
        static let contentEncoding = HeaderName("Content-Encoding")
        static let contentLength = HeaderName("Content-Length")
        static let contentType = HeaderName("Content-Type")
        static let transferEncoding = HeaderName("Transfer-Encoding")
    }
}

public struct HeaderName: Hashable {
    let bytes: [UInt8]
    init(from buffer: RandomAccessSlice<UnsafeRawBufferPointer>) throws {
        for byte in buffer {
            guard Int(byte) < tokens.count && tokens[Int(byte)] else {
                throw HTTPError.invalidHeaderName
            }
        }
        bytes = [UInt8](buffer)
    }

    public init(_ value: String) {
        bytes = [UInt8](value.utf8)
    }

    public var hashValue: Int {
        return bytes.lowercasedHashValue
    }
}

extension HeaderName: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
}

public func == (lhs: HeaderName, rhs: HeaderName) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

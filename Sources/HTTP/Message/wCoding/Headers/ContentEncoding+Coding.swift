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

extension Array where Element == ContentEncoding {
    init<T: UnsafeStreamReader>(from stream: T) throws {
        var values = [ContentEncoding]()
        while true {
            let contentEncoding = try ContentEncoding(from: stream)
            values.append(contentEncoding)
            guard try stream.consume(.comma) else {
                break
            }
            try stream.consume(while: { $0 == .whitespace })
        }
        self = values
    }

    func encode<T: UnsafeStreamWriter>(to stream: T) throws {
        for i in startIndex..<endIndex {
            if i != startIndex {
                try stream.write(.comma)
                try stream.write(.whitespace)
            }
            try self[i].encode(to: stream)
        }
    }
}

extension ContentEncoding {
    private struct Bytes {
        static let gzip = ASCII("gzip")
        static let deflate = ASCII("deflate")
    }

    init<T: UnsafeStreamReader>(from stream: T) throws {
        let bytes = try stream.read(allowedBytes: .token)
        switch bytes.lowercasedHashValue {
        case Bytes.gzip.lowercasedHashValue: self = .gzip
        case Bytes.deflate.lowercasedHashValue: self = .deflate
        default: self = .custom(String(decoding: bytes, as: UTF8.self))
        }
    }

    func encode<T: UnsafeStreamWriter>(to stream: T) throws {
        let bytes: [UInt8]
        switch self {
        case .gzip: bytes = Bytes.gzip
        case .deflate: bytes = Bytes.deflate
        case .custom(let value): bytes = [UInt8](value.utf8)
        }
        try stream.write(bytes)
    }
}

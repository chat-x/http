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

extension Array where Element == Request.AcceptCharset {
    public typealias AcceptCharset = Request.AcceptCharset

    init<T: UnsafeStreamReader>(from stream: T) throws {
        var values = [AcceptCharset]()

        while true {
            let value = try AcceptCharset(from: stream)
            values.append(value)
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
            }
            try self[i].encode(to: stream)
        }
    }
}

extension Request.AcceptCharset {
    private struct Bytes {
        static let qEqual = ASCII("q=")
    }

    init<T: UnsafeStreamReader>(from stream: T) throws {
        self.charset = try Charset(from: stream)

        guard try stream.consume(.semicolon) else {
            self.priority = 1.0
            return
        }

        guard try stream.consume(sequence: Bytes.qEqual) else {
            throw ParseError.invalidAcceptCharsetHeader
        }
        guard let priority = try Double(from: stream) else {
            throw ParseError.invalidAcceptCharsetHeader
        }
        self.priority = priority
    }

    func encode<T: UnsafeStreamWriter>(to stream: T) throws {
        try charset.encode(to: stream)

        if priority < 1.0 {
            try stream.write(.semicolon)
            try stream.write(Bytes.qEqual)
            try stream.write([UInt8](String(describing: priority)))
        }
    }
}

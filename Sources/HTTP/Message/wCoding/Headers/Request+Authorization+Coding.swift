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

extension Request.Authorization {
    private struct Bytes {
        static let basic = ASCII("Basic")
        static let bearer = ASCII("Bearer")
        static let token = ASCII("Token")
    }

    init<T: StreamReader>(from stream: T) throws {
        func readCredentials() throws -> String {
            guard try stream.consume(.whitespace) else {
                throw ParseError.invalidAuthorizationHeader
            }
            // FIXME: validate with value-specific rule
            return try stream.read(allowedBytes: .text) { bytes in
                return String(decoding: bytes, as: UTF8.self)
            }
        }

        self = try stream.read(until: .whitespace) { bytes in
            switch bytes.lowercasedHashValue {
            case Bytes.basic.lowercasedHashValue:
                return .basic(credentials: try readCredentials())
            case Bytes.bearer.lowercasedHashValue:
                return .bearer(credentials: try readCredentials())
            case Bytes.token.lowercasedHashValue:
                return .token(credentials: try readCredentials())
            default:
                return .custom(
                    scheme: String(decoding: bytes, as: UTF8.self),
                    credentials: try readCredentials())
            }
        }
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        switch self {
        case .basic(let credentials):
            try stream.write(Bytes.basic)
            try stream.write(.whitespace)
            try stream.write(credentials)
        case .bearer(let credentials):
            try stream.write(Bytes.bearer)
            try stream.write(.whitespace)
            try stream.write(credentials)
        case .token(let credentials):
            try stream.write(Bytes.token)
            try stream.write(.whitespace)
            try stream.write(credentials)
        case .custom(let schema, let credentials):
            try stream.write(schema)
            try stream.write(.whitespace)
            try stream.write(credentials)
        }
    }
}

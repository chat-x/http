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

public enum Connection {
    case keepAlive
    case close
    case upgrade
}

extension Connection {
    private struct Bytes {
        static let keepAlive = ASCII("keep-alive")
        static let close = ASCII("close")
        static let upgrade = ASCII("Upgrade")
    }

    init<T: InputStream>(from stream: BufferedInputStream<T>) throws {
        // FIXME: validate with value-specific rule
        let bytes = try stream.read(allowedBytes: .token)
        switch bytes.lowercasedHashValue {
        case Bytes.keepAlive.lowercasedHashValue: self = .keepAlive
        case Bytes.close.lowercasedHashValue: self = .close
        case Bytes.upgrade.lowercasedHashValue: self = .upgrade
        default: throw HTTPError.unsupportedContentType
        }
    }

    func encode<T: OutputStream>(to stream: BufferedOutputStream<T>) throws {
        let bytes: [UInt8]
        switch self {
        case .keepAlive: bytes = Bytes.keepAlive
        case .close: bytes = Bytes.close
        case .upgrade: bytes = Bytes.upgrade
        }
        try stream.write(bytes)
    }
}

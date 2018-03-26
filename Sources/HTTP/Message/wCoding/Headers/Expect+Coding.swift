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

extension Expect {
    private struct Bytes {
        static let `continue` = ASCII("100-continue")
    }

    init<T: StreamReader>(from stream: T) throws {
        // FIXME: validate with value-specific rule
        self = try stream.read(allowedBytes: .token) { bytes in
            switch bytes.lowercasedHashValue {
            case Bytes.`continue`.lowercasedHashValue: return .`continue`
            default: throw ParseError.unsupportedExpect
            }
        }
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        let bytes: [UInt8]
        switch self {
        case .`continue`: bytes = Bytes.`continue`
        }
        try stream.write(bytes)
    }
}

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

extension Version {
    private struct Bytes {
        static let httpSlash = ASCII("HTTP/")
        static let oneOne = ASCII("1.1")
    }

    init<T: StreamReader>(from stream: T) throws {
        try stream.read(count: Bytes.httpSlash.count) { bytes in
            guard bytes.elementsEqual(Bytes.httpSlash) else {
                throw ParseError.invalidVersion
            }
        }

        self = try stream.read(count: Bytes.oneOne.count) { bytes in
            guard bytes.elementsEqual(Bytes.oneOne) else {
                throw ParseError.invalidVersion
            }
            return .oneOne
        }
    }

    func encode<T: StreamWriter>(to stream: T) throws {
        try stream.write(Bytes.httpSlash)
        switch self {
        case .oneOne: try stream.write(Bytes.oneOne)
        }
    }
}

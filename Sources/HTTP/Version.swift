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

public enum Version {
    case oneOne
}

extension Version {
    private struct Bytes {
        static let httpSlash = ASCII("HTTP/")
        static let oneOne = ASCII("1.1")
    }

    init<T: UnsafeStreamReader>(from stream: T) throws {
        let prefix = try stream.read(count: Bytes.httpSlash.count)
        guard prefix.elementsEqual(Bytes.httpSlash) else {
            throw HTTPError.invalidVersion
        }
        let varsionBytes = try stream.read(count: Bytes.oneOne.count)
        guard varsionBytes.elementsEqual(Bytes.oneOne) else {
            throw HTTPError.invalidVersion
        }
        self = .oneOne
    }

    func encode<T: UnsafeStreamWriter>(to stream: T) throws {
        try stream.write(Bytes.httpSlash)
        switch self {
        case .oneOne: try stream.write(Bytes.oneOne)
        }
    }
}

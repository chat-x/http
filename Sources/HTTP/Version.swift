/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public enum Version {
    case oneOne
}

extension Version {
    private struct Bytes {
        static let httpSlash = ASCII("HTTP/")
        static let oneOne = ASCII("1.1")

        static let versionLength = httpSlash.count + oneOne.count
    }

    init(from buffer: UnsafeRawBufferPointer.SubSequence) throws {
        guard buffer.starts(with: Bytes.httpSlash) else {
            throw HTTPError.invalidVersion
        }
        let versionIndex = buffer.startIndex + Bytes.httpSlash.count
        let version = UnsafeRawBufferPointer(rebasing: buffer[versionIndex...])
        switch version {
        case _ where version.elementsEqual(Bytes.oneOne): self = .oneOne
        default: throw HTTPError.invalidVersion
        }
    }

    func encode(to buffer: inout [UInt8]) {
        buffer.append(contentsOf: Bytes.httpSlash)
        switch self {
        case .oneOne: buffer.append(contentsOf: Bytes.oneOne)
        }
    }
}

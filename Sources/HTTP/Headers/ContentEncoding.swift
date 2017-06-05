/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public enum ContentEncoding {
    case gzip
    case deflate
    case custom(String)
}

extension ContentEncoding: Equatable {
    public static func ==(lhs: ContentEncoding, rhs: ContentEncoding) -> Bool {
        switch (lhs, rhs) {
        case (.gzip, .gzip): return true
        case (.deflate, .deflate): return true
        case let (.custom(lhs), .custom(rhs)): return lhs == rhs
        default: return false
        }
    }
}

extension Array where Element == ContentEncoding {
    init(from bytes: RandomAccessSlice<UnsafeRawBufferPointer>) throws {
        var startIndex = bytes.startIndex
        var endIndex = startIndex
        var values = [ContentEncoding]()
        while endIndex < bytes.endIndex {
            endIndex =
                bytes.index(of: Character.comma, offset: startIndex) ??
                bytes.endIndex
            let value = try ContentEncoding(from: bytes[startIndex..<endIndex])
            values.append(value)
            startIndex = endIndex.advanced(by: 1)
            if startIndex < bytes.endIndex &&
                bytes[startIndex] == Character.whitespace {
                    startIndex += 1
            }
        }
        self = values
    }

    func encode(to buffer: inout [UInt8]) {
        for i in startIndex..<endIndex {
            if i != startIndex {
                buffer.append(Character.comma)
            }
            self[i].encode(to: &buffer)
        }
    }
}

extension ContentEncoding {
    private struct Bytes {
        static let gzip = ASCII("gzip")
        static let deflate = ASCII("deflate")
    }

    init(from bytes: RandomAccessSlice<UnsafeRawBufferPointer>) throws {
        switch bytes.lowercasedHashValue {
        case Bytes.gzip.lowercasedHashValue: self = .gzip
        case Bytes.deflate.lowercasedHashValue: self = .deflate
        default:
            guard let encoding = String(validating: bytes, as: .token) else {
                throw HTTPError.invalidContentEncoding
            }
            self = .custom(encoding)
        }
    }

    func encode(to buffer: inout [UInt8]) {
        switch self {
        case .gzip: buffer.append(contentsOf: Bytes.gzip)
        case .deflate: buffer.append(contentsOf: Bytes.deflate)
        case .custom(let value): buffer.append(contentsOf: value.utf8)
        }
    }
}

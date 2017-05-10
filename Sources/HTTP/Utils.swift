/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

// MARK: Hash

extension Sequence where Iterator.Element == UInt8 {
    public var hashValue: Int {
        var hash = 5381
        for byte in self {
            hash = ((hash << 5) &+ hash) &+ Int(byte | 0x20)
        }
        return hash
    }
}

// MARK: ASCII

typealias ASCII = [UInt8]
extension Array where Element == UInt8 {
    @inline(__always)
    public init(_ value: String) {
        self = [UInt8](value.utf8)
    }
}

extension UInt8: ExpressibleByStringLiteral {
    private init(_ value: String) {
        self = ASCII(value)[0]
    }

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

// MARK: String initializer from byte sequence (without null terminator)

extension String {
    public init(buffer: UnsafeRawBufferPointer) {
        _debugPrecondition(!buffer.contains(0), "invalid data")
        let count = buffer.count
        let storage = _StringBuffer(
            capacity: count,
            initialSize: count,
            elementWidth: 1)
        storage.start.copyBytes(from: buffer.baseAddress!, count: count)
        self = String(_storage: storage)
    }

    public init(bytes: [UInt8]) {
        self = String(
            buffer: UnsafeRawBufferPointer(start: bytes, count: bytes.count))
    }
}

// MARK: UnsafeRawBufferPointer extension

extension UnsafeRawBufferPointer {
    @inline(__always)
    func index(of element: UInt8, offset: Int) -> Int? {
        guard let index = self.suffix(from: offset).index(of: element) else {
            return nil
        }
        return index + offset
    }
}

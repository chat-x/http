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

extension BufferedInputStream {
    func consume(sequence: [UInt8]) throws -> Bool {
        guard let buffer = try peek(count: sequence.count) else {
            throw StreamError.insufficientData
        }
        guard buffer.elementsEqual(sequence) else {
            return false
        }
        try consume(count: sequence.count)
        return true
    }
}

extension BufferedOutputStream {
    @inline(__always)
    func write(_ string: String) throws {
        let bytes = [UInt8](string.utf8)
        try write(bytes)
    }

    @inline(__always)
    func write(_ bytes: [UInt8]) throws {
        guard try write(bytes, byteCount: bytes.count) == bytes.count else {
            throw StreamError.notEnoughSpace
        }
    }
}

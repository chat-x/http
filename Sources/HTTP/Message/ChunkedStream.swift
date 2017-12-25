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

class ChunkedOutputStream: UnsafeStreamWriter {
    let baseStream: UnsafeStreamWriter

    var buffered: Int {
        return baseStream.buffered
    }

    init(baseStream: UnsafeStreamWriter) {
        self.baseStream = baseStream
    }

    func write(_ bytes: UnsafeRawPointer, byteCount: Int) throws -> Int {
        try baseStream.write(String(byteCount, radix: 16))
        try baseStream.write(Constants.lineEnd)
        var written = 0
        while written < byteCount {
            let count = try baseStream.write(bytes, byteCount: byteCount)
            guard count > 0 else {
                throw StreamError.insufficientData
            }
            written += count
        }
        try baseStream.write(Constants.lineEnd)
        return byteCount
    }

    func close() throws {
        try baseStream.write("0\r\n\r\n")
    }
}

class ChunkedInputStreamReader: InputStream {
    let baseStream: UnsafeStreamReader

    init(baseStream: UnsafeStreamReader) {
        self.baseStream = baseStream
    }

    var closed = false
    var currentChunkBytesLeft = 0

    func readNextChunkSize() throws -> Int {
        let sizeBytes = try baseStream.read(until: .cr)
        try readLineEnd()

        guard let size = Int(from: sizeBytes, radix: 16) else {
            throw ParseError.invalidRequest
        }
        return size
    }

    func read(
        to pointer: UnsafeMutableRawPointer,
        byteCount requested: Int
    ) throws -> Int {
        guard !closed else {
            return 0
        }

        @inline(__always)
        func read(byteCount: Int, offset: Int = 0) throws {
            let buffer = try baseStream.read(count: byteCount)
            pointer.advanced(by: offset).copyMemory(
                from: buffer.baseAddress!,
                byteCount: buffer.count)
        }

        if currentChunkBytesLeft > requested {
            try read(byteCount: requested)
            currentChunkBytesLeft -= requested
            return requested
        }

        var remaining = requested
        if currentChunkBytesLeft > 0 {
            try read(byteCount: currentChunkBytesLeft)
            remaining -= currentChunkBytesLeft
            currentChunkBytesLeft = 0
            try readLineEnd()
        }

        while remaining > 0 {
            currentChunkBytesLeft = try readNextChunkSize()
            guard currentChunkBytesLeft > 0 else {
                try readLineEnd()
                closed = true
                return requested - remaining
            }
            let count = min(remaining, currentChunkBytesLeft)
            try read(byteCount: count, offset: requested - remaining)
            if currentChunkBytesLeft <= remaining {
                try readLineEnd()
            }
            remaining -= count
        }

        return requested
    }

    func close() throws {
        guard !closed else {
            return
        }
        if currentChunkBytesLeft > 0 {
            _ = try baseStream.read(count: currentChunkBytesLeft)
            currentChunkBytesLeft = 0
        }
        while true {
            let size = try readNextChunkSize()
            guard size > 0 else {
                try readLineEnd()
                closed = true
                break
            }
            _ = try baseStream.read(count: size)
        }
    }

    @inline(__always)
    func readLineEnd() throws {
        guard try baseStream.consume(.cr),
            try baseStream.consume(.lf) else {
                throw ParseError.invalidRequest
        }
    }
}

class ChunkedInputStream: UnsafeStreamReader {
    let baseStream: BufferedInputStream<ChunkedInputStreamReader>

    init(baseStream: UnsafeStreamReader) {
        let reader = ChunkedInputStreamReader(baseStream: baseStream)
        self.baseStream = BufferedInputStream(baseStream: reader)
    }

    func close() throws {
        try baseStream.baseStream.close()
    }

    var buffered: Int {
        return baseStream.buffered
    }

    func peek(count: Int) throws -> UnsafeRawBufferPointer? {
        return try baseStream.peek(count: count)
    }

    func read() throws -> UInt8 {
        return try baseStream.read()
    }

    func read(count: Int) throws -> UnsafeRawBufferPointer {
        return try baseStream.read(count: count)
    }

    func read(
        while predicate: (UInt8) -> Bool,
        allowingExhaustion: Bool
    ) throws -> UnsafeRawBufferPointer {
        return try baseStream.read(
            while: predicate, allowingExhaustion: allowingExhaustion)
    }

    func consume(count: Int) throws {
        try baseStream.consume(count: count)
    }

    func consume(_ byte: UInt8) throws -> Bool {
        return try baseStream.consume(byte)
    }

    func consume(
        while predicate: (UInt8) -> Bool,
        allowingExhaustion: Bool
    ) throws {
        return try baseStream.consume(
            while: predicate, allowingExhaustion: allowingExhaustion)
    }
}
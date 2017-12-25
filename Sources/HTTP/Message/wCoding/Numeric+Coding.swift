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
import Platform

extension Int {
    init?<T: UnsafeStreamReader>(from stream: T) throws {
        let bytes = try stream.read(while: { $0 >= .zero && $0 <= .nine })
        guard bytes.count > 0 else {
            return nil
        }
        var value = 0
        for byte in bytes {
            value *= 10
            value += Int(byte - .zero)
        }
        self = value
    }
}

extension Double {
    init?<T: UnsafeStreamReader>(from stream: T) throws {
        var string = [UInt8]()

        let bytes = try stream.read(while: { $0 >= .zero && $0 <= .nine })
        string.append(contentsOf: bytes)

        if (try? stream.consume(.dot)) ?? false {
            string.append(.dot)
            let bytes = try stream.read(while: { $0 >= .zero && $0 <= .nine })
            string.append(contentsOf: bytes)
        }
        string.append(0)

        let pointer = UnsafeRawPointer(string)
            .assumingMemoryBound(to: Int8.self)
        self = strtod(pointer, nil)
    }
}

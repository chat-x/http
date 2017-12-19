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
    func consume(_ byte: UInt8) throws -> Bool {
        guard let buffer = try peek(count: 1), buffer[0] == byte else {
            return false
        }
        try consume(count: 1)
        return true
    }

    func consume(sequence: [UInt8]) throws -> Bool {
        guard let buffer = try peek(count: sequence.count),
            buffer.elementsEqual(sequence) else {
                return false
        }
        try consume(count: sequence.count)
        return true
    }
}

/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import struct Foundation.CharacterSet

extension URL {
    func encode(to buffer: inout [UInt8]) {
        buffer.append(contentsOf: [UInt8](path.utf8))
        if let query = query, query.values.count > 0 {
            buffer.append(.questionMark)
            query.encode(to: &buffer)
        }
        if let fragment = fragment {
            buffer.append(.hash)
            buffer.append(contentsOf: fragment.utf8)
        }
    }
}

extension URL.Query {
    public func encode(to buffer: inout [UInt8]) {
        let queryString = self.description
        buffer.append(contentsOf: queryString.utf8)
    }
}

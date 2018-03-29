/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import HTTP
import Stream

extension Response {
    func encode() throws -> String {
        let stream = OutputByteStream()
        try encode(to: stream)
        return String(decoding: stream.bytes, as: UTF8.self)
    }
}

extension Request {
    func encode() throws -> String {
        let stream = OutputByteStream()
        try encode(to: stream)
        return String(decoding: stream.bytes, as: UTF8.self)
    }
}

extension InputByteStream {
    convenience
    init(_ string: String) {
        self.init([UInt8](string.utf8))
    }
}

extension OutputByteStream {
    var string: String {
        return String(decoding: bytes, as: UTF8.self)
    }
}

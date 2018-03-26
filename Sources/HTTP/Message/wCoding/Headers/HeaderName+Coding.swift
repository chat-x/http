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

extension HeaderName {
    init<T: StreamReader>(from stream: T) throws {
        let bytes = try stream.read(allowedBytes: .token)
        guard bytes.count > 0 else {
            throw ParseError.invalidHeaderName
        }
        self.init(bytes)
    }
}

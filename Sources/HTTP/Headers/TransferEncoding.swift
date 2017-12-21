/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public enum TransferEncoding {
    case chunked
    case compress
    case deflate
    case gzip
    case identity
}

extension TransferEncoding: Equatable {
    public static func ==(
        lhs: TransferEncoding,
        rhs: TransferEncoding
    ) -> Bool {
        switch (lhs, rhs) {
        case (.chunked, .chunked): return true
        case (.compress, .compress): return true
        case (.deflate, .deflate): return true
        case (.gzip, .gzip): return true
        case (.identity, .identity): return true
        default: return false
        }
    }
}

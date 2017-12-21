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

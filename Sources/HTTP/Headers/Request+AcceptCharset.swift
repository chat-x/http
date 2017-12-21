/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

extension Request {
    public struct AcceptCharset {
        public let charset: Charset
        public let priority: Double

        public init(_ charset: Charset, priority: Double = 1.0) {
            self.charset = charset
            self.priority = priority
        }
    }
}

extension Request.AcceptCharset: Equatable {
    public typealias AcceptCharset = Request.AcceptCharset
    public static func ==(lhs: AcceptCharset, rhs: AcceptCharset) -> Bool {
        guard lhs.priority == rhs.priority else {
            return false
        }
        switch (lhs.charset, rhs.charset) {
        case (.utf8, .utf8): return true
        case (.isoLatin1, .isoLatin1): return true
        case (.any, .any): return true
        case let (.custom(lhs), .custom(rhs)): return lhs == rhs
        default: return false
        }
    }
}

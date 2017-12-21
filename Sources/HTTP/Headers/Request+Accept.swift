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
    public struct Accept {
        public let mediaType: MediaType
        public let priority: Double

        public init(_ mediaType: MediaType, priority: Double = 1.0) {
            self.mediaType = mediaType
            self.priority = priority
        }
    }
}

extension Request.Accept: Equatable {
    public typealias Accept = Request.Accept
    public static func ==(lhs: Accept, rhs: Accept) -> Bool {
        return lhs.mediaType == rhs.mediaType &&
            lhs.priority == rhs.priority
    }
}

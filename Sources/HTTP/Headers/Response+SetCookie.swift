/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import struct Foundation.Date
import struct Foundation.TimeZone
import class Foundation.DateFormatter

extension Response {
    public struct SetCookie {
        public var cookie: Cookie
        public var domain: String? = nil
        public var path: String? = nil
        public var expires: Date? = nil
        public var maxAge: Int? = nil
        public var secure: Bool? = nil
        public var httpOnly: Bool? = nil

        public init(
            _ cookie: Cookie,
            domain: String? = nil,
            path: String? = nil,
            expires: Date? = nil,
            maxAge: Int? = nil,
            secure: Bool? = nil,
            httpOnly: Bool? = nil
        ) {
            self.cookie = cookie
            self.domain = domain
            self.path = path
            self.expires = expires
            self.maxAge = maxAge
            self.secure = secure
            self.httpOnly = httpOnly
        }
    }
}

extension Response.SetCookie: Equatable {
    public typealias SetCookie = Response.SetCookie
    public static func ==(lhs: SetCookie, rhs: SetCookie) -> Bool {
        return lhs.cookie == rhs.cookie &&
            lhs.domain == rhs.domain &&
            lhs.path == rhs.path &&
            lhs.expires == rhs.expires &&
            lhs.maxAge == rhs.maxAge &&
            lhs.secure == rhs.secure &&
            lhs.httpOnly == rhs.httpOnly
    }
}

extension Date {
    static var decodeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "EEE, dd'-'MMM'-'yy HH:mm:ss z"
        return formatter
    }

    #if os(Linux)
    static var decodeFormatterLinuxBug: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        return formatter
    }
    #endif

    static var encodeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        return formatter
    }

    init?(from string: String) {
        guard let date = Date.decodeFormatter.date(from: string) else {
            #if os(Linux)
            if let date = Date.decodeFormatterLinuxBug.date(from: string) {
                self = date
                return
            }
            #endif
            return nil
        }
        self = date
    }

    var rawValue: [UInt8] {
        return [UInt8](Date.encodeFormatter.string(from: self).utf8)
    }
}

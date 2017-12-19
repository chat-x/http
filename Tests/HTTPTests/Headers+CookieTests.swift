/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Test
import Stream
@testable import HTTP

class HeadersCookieTests: TestCase {
    func testCookie() {
        let expected = Cookie(name: "username", value: "tony")

        let bytes = ASCII("username=tony")
        let buffer = UnsafeRawBufferPointer(start: bytes, count: bytes.count)

        let cookie = try? Cookie(from: buffer[...])
        assertEqual(cookie, expected)

        var encoded = [UInt8]()
        cookie?.encode(to: &encoded)
        assertEqual(encoded, bytes)
    }

    func testJoinedCookie() {
        let expected: [Cookie] = [
            Cookie(name: "username", value: "tony"),
            Cookie(name: "lang", value: "aurebesh")
        ]

        let bytes = ASCII("username=tony; lang=aurebesh")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        let cookie = try? [Cookie](from: stream)
        assertEqual(cookie ?? [], expected)
    }

    func testJoinedCookieNoSpace() {
        let bytes = ASCII("username=tony;lang=aurebesh")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        assertThrowsError(try [Cookie](from: stream)) { error in
            assertEqual(error as? HTTPError, .invalidCookie)
        }
    }

    func testTrailingSemicolon() {
        let bytes = ASCII("username=tony;")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        assertThrowsError(try [Cookie](from: stream)) { error in
            assertEqual(error as? HTTPError, .invalidCookie)
        }
    }


    static var allTests = [
        ("testCookie", testCookie),
        ("testJoinedCookie", testJoinedCookie),
        ("testJoinedCookieNoSpace", testJoinedCookieNoSpace),
        ("testTrailingSemicolon", testTrailingSemicolon),
    ]
}

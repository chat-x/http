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

import struct Foundation.Date

class HeadersSetCookieTests: TestCase {
    func testSetCookie() {
        let expected = Response.SetCookie(
            Cookie(name: "username", value: "tony"))

        let bytes = ASCII("username=tony")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        let setCookie = try? Response.SetCookie(from: stream)
        assertEqual(setCookie, expected)

        var encoded = [UInt8]()
        setCookie?.encode(to: &encoded)
        assertEqual(encoded, bytes)
    }

    func testExpires() {
        let expected = Response.SetCookie(
            Cookie(name: "username", value: "tony"),
            expires: Date(timeIntervalSinceReferenceDate: 467105280))

        let bytes = ASCII(
            "username=tony; Expires=Wed, 21 Oct 2015 07:28:00 GMT")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        let setCookie = try? Response.SetCookie(from: stream)
        assertEqual(setCookie, expected)

        var encoded = [UInt8]()
        setCookie?.encode(to: &encoded)
        assertEqual(encoded, bytes)
    }

    func testMaxAge() {
        let expected = Response.SetCookie(
            Cookie(name: "username", value: "tony"),
            maxAge: 42)

        let bytes = ASCII("username=tony; Max-Age=42")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        let setCookie = try? Response.SetCookie(from: stream)
        assertEqual(setCookie, expected)

        var encoded = [UInt8]()
        setCookie?.encode(to: &encoded)
        assertEqual(encoded, bytes)
    }

    func testHttpOnly() {
        let expected = Response.SetCookie(
            Cookie(name: "username", value: "tony"),
            httpOnly: true)

        let bytes = ASCII("username=tony; HttpOnly")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        let setCookie = try? Response.SetCookie(from: stream)
        assertEqual(setCookie, expected)

        var encoded = [UInt8]()
        setCookie?.encode(to: &encoded)
        assertEqual(encoded, bytes)
    }

    func testSecure() {
        let expected = Response.SetCookie(
            Cookie(name: "username", value: "tony"),
            secure: true)

        let bytes = ASCII("username=tony; Secure")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        let setCookie = try? Response.SetCookie(from: stream)
        assertEqual(setCookie, expected)

        var encoded = [UInt8]()
        setCookie?.encode(to: &encoded)
        assertEqual(encoded, bytes)
    }

    func testDomain() {
        let expected = Response.SetCookie(
            Cookie(name: "username", value: "tony"),
            domain: "somedomain.com")

        let bytes = ASCII("username=tony; Domain=somedomain.com")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        let setCookie = try? Response.SetCookie(from: stream)
        assertEqual(setCookie, expected)

        var encoded = [UInt8]()
        setCookie?.encode(to: &encoded)
        assertEqual(encoded, bytes)
    }

    func testPath() {
        let expected = Response.SetCookie(
            Cookie(name: "username", value: "tony"),
            path: "/")

        let bytes = ASCII("username=tony; Path=/")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))

        let setCookie = try? Response.SetCookie(from: stream)
        assertEqual(setCookie, expected)

        var encoded = [UInt8]()
        setCookie?.encode(to: &encoded)
        assertEqual(encoded, bytes)
    }


    static var allTests = [
        ("testSetCookie", testSetCookie),
        ("testExpires", testExpires),
        ("testMaxAge", testMaxAge),
        ("testHttpOnly", testHttpOnly),
        ("testSecure", testSecure),
        ("testDomain", testDomain),
        ("testPath", testPath),
    ]
}

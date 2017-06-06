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
@testable import HTTP

class EncodeResponseTests: TestCase {
    func testOk() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n"
        let response = Response(status: .ok)
        assertEqual(response.status, .ok)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testNotFound() {
        let expected = "HTTP/1.1 404 Not Found\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n"
        let response = Response(status: .notFound)
        assertEqual(response.status, .notFound)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testMoved() {
        let expected = "HTTP/1.1 301 Moved Permanently\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n"
        let response = Response(status: .moved)
        assertEqual(response.status, .moved)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testBad() {
        let expected = "HTTP/1.1 400 Bad Request\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n"
        let response = Response(status: .badRequest)
        assertEqual(response.status, .badRequest)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testUnauthorized() {
        let expected = "HTTP/1.1 401 Unauthorized\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n"
        let response = Response(status: .unauthorized)
        assertEqual(response.status, .unauthorized)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testInternalServerError() {
        let expected = "HTTP/1.1 500 Internal Server Error\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n"
        let response = Response(status: .internalServerError)
        assertEqual(response.status, .internalServerError)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testContentType() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Type: text/plain\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n"
        var response = Response()
        response.contentType = ContentType(mediaType: .text(.plain))
        assertEqual(response.contentLength, 0)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testResponseHasContentLenght() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n"
        let response = Response(status: .ok)
        assertEqual(response.status, .ok)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testConnection() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Length: 0\r\n" +
            "Connection: close\r\n" +
            "\r\n"
        var response = Response(status: .ok)
        response.connection = .close
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testContentEncoding() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Length: 0\r\n" +
            "Content-Encoding: gzip,deflate\r\n" +
            "\r\n"
        var response = Response(status: .ok)
        response.contentEncoding = [.gzip, .deflate]
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testTransferEncoding() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Length: 0\r\n" +
            "Transfer-Encoding: chunked\r\n" +
            "\r\n"
        var response = Response(status: .ok)
        response.transferEncoding = [.chunked]
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testCustomHeader() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Length: 0\r\n" +
            "User: guest\r\n" +
            "\r\n"
        var response = Response(status: .ok)
        response.headers["User"] = "guest"
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testStringResponse() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Type: text/plain\r\n" +
            "Content-Length: 5\r\n" +
            "\r\n" +
            "Hello"
        let response = Response(string: "Hello")
        guard let rawBody = response.rawBody,
            let body = response.body else {
                fail("body shouldn't be nil")
                return
        }
        assertEqual(body, "Hello")
        assertEqual(rawBody, ASCII("Hello"))
        assertEqual(
            response.contentType,
            ContentType(mediaType: .text(.plain))
        )
        assertEqual(response.contentLength, ASCII("Hello").count)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testHtmlResponse() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Type: text/html\r\n" +
            "Content-Length: 13\r\n" +
            "\r\n" +
            "<html></html>"
        let response = Response(html: "<html></html>")
        guard let rawBody = response.rawBody,
            let body = response.body else {
                fail("body shouldn't be nil")
                return
        }
        assertEqual(body, "<html></html>")
        assertEqual(rawBody, ASCII("<html></html>"))
        assertEqual(
            response.contentType,
            ContentType(mediaType: .text(.html))
        )
        assertEqual(response.contentLength, 13)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testBytesResponse() {
        let expected = ASCII("HTTP/1.1 200 OK\r\n" +
            "Content-Type: application/stream\r\n" +
            "Content-Length: 3\r\n" +
            "\r\n") + [1,2,3]
        let data: [UInt8] = [1,2,3]
        let response = Response(bytes: data)
        guard let rawBody = response.rawBody else {
            fail("body shouldn't be nil")
            return
        }
        assertEqual(rawBody, data)
        assertEqual(
            response.contentType,
            ContentType(mediaType: .application(.stream))
        )
        assertEqual(response.contentLength, 3)
        assertEqual(response.bytes, expected)
    }

    func testJsonResponse() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Type: application/json\r\n" +
            "Content-Length: 27\r\n" +
            "\r\n" +
            "{\"message\":\"Hello, World!\"}"
        guard let response = try? Response(json: ["message" : "Hello, World!"]),
            let rawBody = response.rawBody,
            let body = response.body else {
                fail("body shouldn't be nil")
                return
        }
        assertEqual(body, "{\"message\":\"Hello, World!\"}")
        assertEqual(rawBody, ASCII("{\"message\":\"Hello, World!\"}"))
        assertEqual(
            response.contentType,
            ContentType(mediaType: .application(.json))
        )
        assertEqual(response.contentLength, 27)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testUrlEncodedResponse() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Type: application/x-www-form-urlencoded\r\n" +
            "Content-Length: 23\r\n" +
            "\r\n" +
            "message=Hello,%20World!"
        let response = Response(urlEncoded: ["message" : "Hello, World!"])
        guard let rawBody = response.rawBody,
            let body = response.body else {
                fail("body shouldn't be nil")
                return
        }
        assertEqual(body, "message=Hello,%20World!")
        assertEqual(rawBody, ASCII("message=Hello,%20World!"))
        assertEqual(
            response.contentType,
            ContentType(mediaType: .application(.urlEncoded))
        )
        assertEqual(response.contentLength, 23)
        assertEqual(String(ascii: response.bytes), expected)
    }

    func testSetCookie() {
        let expected = "HTTP/1.1 200 OK\r\n" +
            "Content-Length: 0\r\n" +
            "Set-Cookie: user=tony; Secure; HttpOnly\r\n" +
            "Set-Cookie: token=1234; Max-Age=42; Secure\r\n" +
            "\r\n"
        var response = Response()
        response.setCookie = [
            Response.SetCookie(
                Cookie(name: "user", value: "tony"),
                secure: true,
                httpOnly: true),
            Response.SetCookie(
                Cookie(name: "token", value: "1234"),
                maxAge: 42,
                secure: true)
        ]
        assertEqual(String(ascii: response.bytes), expected)
    }


    static var allTests = [
        ("testOk", testOk),
        ("testMoved", testMoved),
        ("testBad", testBad),
        ("testUnauthorized", testUnauthorized),
        ("testNotFound", testNotFound),
        ("testInternalServerError", testInternalServerError),
        ("testResponseHasContentLenght", testResponseHasContentLenght),
        ("testConnection", testConnection),
        ("testContentEncoding", testContentEncoding),
        ("testTransferEncoding", testTransferEncoding),
        ("testCustomHeader", testCustomHeader),
        ("testContentType", testContentType),
        ("testStringResponse", testStringResponse),
        ("testHtmlResponse", testHtmlResponse),
        ("testBytesResponse", testBytesResponse),
        ("testJsonResponse", testJsonResponse),
        ("testUrlEncodedResponse", testUrlEncodedResponse),
    ]
}

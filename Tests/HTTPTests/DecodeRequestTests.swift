/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

@testable import HTTP

class DecodeRequestTests: TestCase {

    // MARK: Start line

    func testGet() {
        do {
            let bytes = ASCII("GET /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.get)
        } catch {
            fail(String(describing: error))
        }
    }

    func testHead() {
        do {
            let bytes = ASCII("HEAD /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.head)
        } catch {
            fail(String(describing: error))
        }
    }

    func testPost() {
        do {
            let bytes = ASCII("POST /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.post)
        } catch {
            fail(String(describing: error))
        }
    }

    func testPut() {
        do {
            let bytes = ASCII("PUT /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.put)
        } catch {
            fail(String(describing: error))
        }
    }

    func testDelete() {
        do {
            let bytes = ASCII("DELETE /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.delete)
        } catch {
            fail(String(describing: error))
        }
    }

    func testVersion() {
        do {
            let bytes = ASCII("GET /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request)
            assertEqual(request.version, Version.oneOne)
        } catch {
            fail(String(describing: error))
        }
    }

    func testUrl() {
        do {
            let bytes = ASCII("GET /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request)
            assertNotNil(request.url)
            assertEqual(request.url.path, "/test")
        } catch {
            fail(String(describing: error))
        }
    }

    func testUrlString() {
        do {
            let bytes = ASCII("GET /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request)
            assertNotNil(request.url)
            assertEqual(request.url.path, "/test")
            assertEqual(request.url, "/test")
        } catch {
            fail(String(describing: error))
        }
    }

    func testInvalidRequest() {
        let bytes = ASCII("GET\r\n\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .unexpectedEnd)
        }
    }

    func testInvalidRequest2() {
        let bytes = ASCII("GET \r\n\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .unexpectedEnd)
        }
    }

    func testInvalidMethod() {
        let bytes = ASCII("BAD /test HTTP/1.1\r\n\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .invalidMethod)
        }
    }

    func testInvalidVersion() {
        let bytes = ASCII("GET /test HTTP/0.1\r\n\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .invalidVersion)
        }
    }

    func testInvalidVersion2() {
        let bytes = ASCII("GET /test HTTP/1.1WUT\r\n\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .invalidVersion)
        }
    }

    func testInvalidVersion3() {
        let bytes = ASCII("GET /test HTTP/1.")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .unexpectedEnd)
        }
    }

    func testInvalidVersion4() {
        let bytes = ASCII("GET /test HTPP/1.1\r\n\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .invalidVersion)
        }
    }

    func testInvalidEnd() {
        let bytes = ASCII("GET /test HTTP/1.1\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .unexpectedEnd)
        }
    }

    // MARK: Headers

    func testHostHeader() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Host: 0.0.0.0=5000\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request.host)
            if let host = request.host {
                assertEqual(host, "0.0.0.0=5000")
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testUserAgentHeader() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "User-Agent: Mozilla/5.0\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request.userAgent)
            if let userAgent = request.userAgent {
                assertEqual(userAgent, "Mozilla/5.0")
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testAcceptCharset() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Accept-Charset: ISO-8859-1,utf-7,utf-8;q=0.7,*;q=0.7\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            let expectedAcceptCharset = [
                AcceptCharset(.isoLatin1),
                AcceptCharset(.custom("utf-7")),
                AcceptCharset(.utf8, priority: 0.7),
                AcceptCharset(.any, priority: 0.7)
            ]
            assertNotNil(request.acceptCharset)
            if let acceptCharset = request.acceptCharset {
                assertEqual(acceptCharset, expectedAcceptCharset)
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testAcceptCharsetSpaceSeparator() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Accept-Charset: ISO-8859-1, utf-8\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            let expectedAcceptCharset = [
                AcceptCharset(.isoLatin1),
                AcceptCharset(.utf8)
            ]
            assertNotNil(request.acceptCharset)
            if let acceptCharset = request.acceptCharset {
                assertEqual(acceptCharset, expectedAcceptCharset)
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testCustomHeader() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "User: guest\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            assertEqual(request.headers["User"], "guest")
        } catch {
            fail(String(describing: error))
        }
    }

    func testTwoHeaders() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Host: 0.0.0.0=5000\r\n" +
                "User-Agent: Mozilla/5.0\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request.host)
            assertNotNil(request.userAgent)
            if let userAgent = request.userAgent, let host = request.host {
                assertEqual(host, "0.0.0.0=5000")
                assertEqual(userAgent, "Mozilla/5.0")
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testTwoHeadersOptionalSpaces() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Host:0.0.0.0=5000\r\n" +
                "User-Agent: Mozilla/5.0 \r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            assertNotNil(request.host)
            assertNotNil(request.userAgent)
            if let userAgent = request.userAgent, let host = request.host {
                assertEqual(host, "0.0.0.0=5000")
                assertEqual(userAgent, "Mozilla/5.0")
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testInvalidHeaderColon() {
        let bytes = ASCII(
            "GET / HTTP/1.1\r\n" +
            "User-Agent; Mozilla/5.0\r\n" +
            "\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .unexpectedEnd)
        }
    }

    func testInvalidHeaderEnd() {
        let bytes = ASCII(
            "GET / HTTP/1.1\r\n" +
            "User-Agent; Mozilla/5.0\n\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .unexpectedEnd)
        }
    }

    func testInvalidHeaderName() {
        let bytes = ASCII(
            "GET / HTTP/1.1\r\n" +
            "See-🙈-Evil: No\r\n" +
            "\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .invalidHeaderName)
        }
    }

    func testHeaderName() {
        let headerName = HeaderName(extendedGraphemeClusterLiteral: "Host")
        let headerName2 = HeaderName(unicodeScalarLiteral: "Host")
        assertEqual(headerName, headerName2)
    }

    func testUnexpectedEnd() {
        let bytes = ASCII(
            "GET / HTTP/1.1\r\n" +
            "Header: Value\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .unexpectedEnd)
        }
    }

    func testContentType() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Content-Type: application/x-www-form-urlencoded\r\n" +
                "\r\n" +
                "Hello")
            let request = try Request(from: bytes)
            assertNotNil(request.contentType)
            if let contentType = request.contentType {
                assertEqual(contentType, .urlEncoded)
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testContentLength() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Content-Length: 5\r\n" +
                "\r\n" +
                "Hello")
            let request = try Request(from: bytes)
            assertNotNil(request.contentLength)
            if let contentLength = request.contentLength {
                assertEqual(contentLength, 5)
            }
        } catch {
            fail(String(describing: error))
        }
    }

    func testZeroContentLength() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Content-Length: 0\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            guard let contentLength = request.contentLength else {
                fail("contentLength in nil")
                return
            }
            assertEqual(contentLength, 0)
            assertNil(request.rawBody)
        } catch {
            fail(String(describing: error))
        }
    }

    func testKeepAliveFalse() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Connection: Close\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            assertFalse(request.shouldKeepAlive)
        } catch {
            fail(String(describing: error))
        }
    }

    func testKeepAliveTrue() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Connection: Keep-Alive\r\n" +
                "Keep-Alive: 300\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            assertTrue(request.shouldKeepAlive)
            assertEqual(request.keepAlive, 300)
        } catch {
            fail(String(describing: error))
        }
    }

    func testTransferEncodingChunked() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Transfer-Encoding: chunked\r\n" +
                "\r\n")
            let request = try Request(from: bytes)
            assertEqual(request.transferEncoding ?? [], [.chunked])
        } catch {
            fail(String(describing: error))
        }
    }

    // MARK: Body

    func testChunkedBody() {
        do {
            let bytes = ASCII(
                "GET / HTTP/1.1\r\n" +
                "Transfer-Encoding: chunked\r\n" +
                "\r\n" +
                "5\r\nHello\r\n" +
                "0\r\n")
            let request = try Request(from: bytes)
            assertEqual(request.body, "Hello")
        } catch {
            fail(String(describing: error))
        }
    }

    func testChunkedBodyInvalidSizeSeparator() {
        let bytes = ASCII(
            "GET / HTTP/1.1\r\n" +
            "Transfer-Encoding: chunked\r\n" +
            "\r\n" +
            "5\rHello\r\n" +
            "0\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .invalidRequest)
        }
    }

    func testChunkedBodyNoSizeSeparator() {
        let bytes = ASCII(
            "GET / HTTP/1.1\r\n" +
            "Transfer-Encoding: chunked\r\n" +
            "\r\n" +
            "5 Hello\r\n" +
            "0\r\n")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .invalidRequest)
        }
    }

    func testChunkedInvalidBody() {
        let bytes = ASCII(
            "GET / HTTP/1.1\r\n" +
            "Transfer-Encoding: chunked\r\n" +
            "\r\n" +
            "5\r\nHello")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .unexpectedEnd)
        }
    }

    func testChunkedJunkAfterBody() {
        let bytes = ASCII(
            "GET / HTTP/1.1\r\n" +
            "Transfer-Encoding: chunked\r\n" +
            "\r\n" +
            "5\r\nHello\r\n" +
            "0\r\n" +
            "WAT")
        assertThrowsError(try Request(from: bytes)) { error in
            assertEqual(error as? HTTPError, .unexpectedEnd)
        }
    }


    static var allTests = [
        ("testGet", testGet),
        ("testHead", testHead),
        ("testPost", testPost),
        ("testPut", testPut),
        ("testDelete", testDelete),
        ("testVersion", testVersion),
        ("testUrl", testUrl),
        ("testUrlString", testUrlString),
        ("testInvalidRequest", testInvalidRequest),
        ("testInvalidRequest2", testInvalidRequest2),
        ("testInvalidMethod", testInvalidMethod),
        ("testInvalidVersion", testInvalidVersion),
        ("testInvalidVersion2", testInvalidVersion2),
        ("testInvalidVersion3", testInvalidVersion3),
        ("testInvalidVersion4", testInvalidVersion4),
        ("testInvalidEnd", testInvalidEnd),
        ("testHostHeader", testHostHeader),
        ("testUserAgentHeader", testUserAgentHeader),
        ("testAcceptCharset",testAcceptCharset),
        ("testAcceptCharsetSpaceSeparator", testAcceptCharsetSpaceSeparator),
        ("testCustomHeader", testCustomHeader),
        ("testTwoHeaders", testTwoHeaders),
        ("testTwoHeadersOptionalSpaces", testTwoHeadersOptionalSpaces),
        ("testInvalidHeaderColon", testInvalidHeaderColon),
        ("testInvalidHeaderName", testInvalidHeaderName),
        ("testInvalidHeaderEnd", testInvalidHeaderEnd),
        ("testHeaderName", testHeaderName),
        ("testUnexpectedEnd", testUnexpectedEnd),
        ("testContentType", testContentType),
        ("testContentLength", testContentLength),
        ("testZeroContentLength", testZeroContentLength),
        ("testKeepAliveFalse", testKeepAliveFalse),
        ("testKeepAliveTrue", testKeepAliveTrue),
        ("testTransferEncodingChunked", testTransferEncodingChunked),
        ("testChunkedBody", testChunkedBody),
        ("testChunkedBodyInvalidSizeSeparator", testChunkedBodyInvalidSizeSeparator),
        ("testChunkedBodyNoSizeSeparator", testChunkedBodyNoSizeSeparator),
        ("testChunkedInvalidBody", testChunkedInvalidBody),
        ("testChunkedJunkAfterBody", testChunkedJunkAfterBody)
    ]
}

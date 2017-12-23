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

class RequestDecodeTests: TestCase {

    // MARK: Start line

    func testGet() {
        do {
            let stream = InputByteStream("GET /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: stream)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.get)
        } catch {
            fail(String(describing: error))
        }
    }

    func testHead() {
        do {
            let stream = InputByteStream("HEAD /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: stream)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.head)
        } catch {
            fail(String(describing: error))
        }
    }

    func testPost() {
        do {
            let stream = InputByteStream("POST /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: stream)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.post)
        } catch {
            fail(String(describing: error))
        }
    }

    func testPut() {
        do {
            let stream = InputByteStream("PUT /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: stream)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.put)
        } catch {
            fail(String(describing: error))
        }
    }

    func testDelete() {
        do {
            let stream = InputByteStream("DELETE /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: stream)
            assertNotNil(request)
            assertEqual(request.method, Request.Method.delete)
        } catch {
            fail(String(describing: error))
        }
    }

    func testVersion() {
        do {
            let stream = InputByteStream("GET /test HTTP/1.1\r\n\r\n")
            let request = try Request(from: stream)
            assertNotNil(request)
            assertEqual(request.version, Version.oneOne)
        } catch {
            fail(String(describing: error))
        }
    }

    func testUrl() {
        do {
            let stream = InputByteStream("GET /test?key=value#fragment HTTP/1.1\r\n\r\n")
            let request = try Request(from: stream)
            assertNotNil(request)
            assertNotNil(request.url)
            assertEqual(request.url.path, "/test")
            assertEqual(request.url.query?.values ?? [:], ["key": "value"])
            assertEqual(request.url.fragment, "fragment")
        } catch {
            fail(String(describing: error))
        }
    }

    func testInvalidRequest() {
        let stream = InputByteStream("GET\r\n\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidStartLine)
        }
    }

    func testInvalidRequest2() {
        let stream = InputByteStream("GET \r\n\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidStartLine)
        }
    }

    func testInvalidMethod() {
        let stream = InputByteStream("BAD /test HTTP/1.1\r\n\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidMethod)
        }
    }

    func testInvalidVersion() {
        let stream = InputByteStream("GET /test HTTP/0.1\r\n\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidVersion)
        }
    }

    func testInvalidVersion2() {
        let stream = InputByteStream("GET /test HTTP/1.1WUT\r\n\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidRequest)
        }
    }

    func testInvalidVersion3() {
        let stream = InputByteStream("GET /test HTTP/1.")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .unexpectedEnd)
        }
    }

    func testInvalidVersion4() {
        let stream = InputByteStream("GET /test HTPP/1.1\r\n\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidVersion)
        }
    }

    func testInvalidEnd() {
        let stream = InputByteStream("GET /test HTTP/1.1\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .unexpectedEnd)
        }
    }

    // MARK: Headers

    func testHostHeader() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Host: 0.0.0.0:5000\r\n" +
                "\r\n")
            let expected = URL.Host(address: "0.0.0.0", port: 5000)
            let request = try Request(from: stream)
            assertEqual(request.host, expected)
        } catch {
            fail(String(describing: error))
        }
    }

    func testHostDomainHeader() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Host: domain.com:5000\r\n" +
                "\r\n")
            let expected = URL.Host(address: "domain.com", port: 5000)
            let request = try Request(from: stream)
            assertEqual(request.host, expected)
        } catch {
            fail(String(describing: error))
        }
    }

    func testHostEncodedHeader() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Host: xn--d1acufc.xn--p1ai:5000\r\n" +
                "\r\n")
            let expected = URL.Host(address: "домен.рф", port: 5000)
            let request = try Request(from: stream)
            assertEqual(request.host, expected)
        } catch {
            fail(String(describing: error))
        }
    }

    func testUserAgentHeader() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "User-Agent: Mozilla/5.0\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.userAgent, "Mozilla/5.0")
        } catch {
            fail(String(describing: error))
        }
    }

    func testAcceptHeader() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Accept: text/html,application/xml;q=0.9,*/*;q=0.8\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.accept, [
                Request.Accept(.text(.html),priority: 1.0),
                Request.Accept(.application(.xml), priority: 0.9),
                Request.Accept(.any, priority: 0.8)
            ])
        } catch {
            fail(String(describing: error))
        }
    }

    func testAcceptLanguageHeader() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Accept-Language: en-US,en;q=0.5\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.acceptLanguage, [
                Request.AcceptLanguage(.enUS, priority: 1.0),
                Request.AcceptLanguage(.en, priority: 0.5)
            ])
        } catch {
            fail(String(describing: error))
        }
    }

    func testAcceptEncodingHeader() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Accept-Encoding: gzip, deflate\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.acceptEncoding, [.gzip, .deflate])
        } catch {
            fail(String(describing: error))
        }
    }

    func testAcceptCharset() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Accept-Charset: ISO-8859-1,utf-7,utf-8;q=0.7,*;q=0.7\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            let expectedAcceptCharset = [
                Request.AcceptCharset(.isoLatin1),
                Request.AcceptCharset(.custom("utf-7")),
                Request.AcceptCharset(.utf8, priority: 0.7),
                Request.AcceptCharset(.any, priority: 0.7)
            ]
            assertEqual(request.acceptCharset, expectedAcceptCharset)
        } catch {
            fail(String(describing: error))
        }
    }

    func testAcceptCharsetSpaceSeparator() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Accept-Charset: ISO-8859-1, utf-8\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            let expectedAcceptCharset = [
                Request.AcceptCharset(.isoLatin1),
                Request.AcceptCharset(.utf8)
            ]
            assertEqual(request.acceptCharset, expectedAcceptCharset)
        } catch {
            fail(String(describing: error))
        }
    }

    func testAuthorization() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            let expected: Request.Authorization = .basic(
                credentials: "QWxhZGRpbjpvcGVuIHNlc2FtZQ==")
            assertEqual(request.authorization, expected)
        } catch {
            fail(String(describing: error))
        }
    }

    func testCustomHeader() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "User: guest\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.headers["User"], "guest")
        } catch {
            fail(String(describing: error))
        }
    }

    func testTwoHeaders() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Host: 0.0.0.0:5000\r\n" +
                "User-Agent: Mozilla/5.0\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.host, URL.Host(address: "0.0.0.0", port: 5000))
            assertEqual(request.userAgent, "Mozilla/5.0")
        } catch {
            fail(String(describing: error))
        }
    }

    func testTwoHeadersOptionalSpaces() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Host:0.0.0.0:5000\r\n" +
                "User-Agent: Mozilla/5.0 \r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.host, URL.Host(address: "0.0.0.0", port: 5000))
            assertEqual(request.userAgent, "Mozilla/5.0")
        } catch {
            fail(String(describing: error))
        }
    }

    func testInvalidHeaderColon() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "User-Agent; Mozilla/5.0\r\n" +
            "\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidHeaderName)
        }
    }

    func testInvalidHeaderEnd() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "User-Agent: Mozilla/5.0\n\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .unexpectedEnd)
        }
    }

    func testInvalidHeaderName() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "See-🙈-Evil: No\r\n" +
            "\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidHeaderName)
        }
    }

    func testHeaderName() {
        let headerName = HeaderName(extendedGraphemeClusterLiteral: "Host")
        let headerName2 = HeaderName(unicodeScalarLiteral: "Host")
        assertEqual(headerName, headerName2)
    }

    func testUnexpectedEnd() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "Header: Value\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .unexpectedEnd)
        }
    }

    func testContentType() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Content-Type: application/x-www-form-urlencoded\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(
                request.contentType,
                ContentType(mediaType: .application(.formURLEncoded))
            )
        } catch {
            fail(String(describing: error))
        }
    }

    func testContentTypeCharset() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Content-Type: text/plain; charset=utf-8\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(
                request.contentType,
                ContentType(mediaType: .text(.plain), charset: .utf8)
            )
        } catch {
            fail(String(describing: error))
        }
    }

    func testContentTypeEmptyCharset() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "Content-Type: text/plain;\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual((error as! ParseError), .invalidContentTypeHeader)
        }
    }

    func testContentTypeBoundary() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Content-Type: multipart/form-data; boundary=---\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(
                request.contentType,
                ContentType(
                    multipart: .formData,
                    boundary: try Boundary("---"))
            )
        } catch {
            fail(String(describing: error))
        }
    }

    func testContentTypeEmptyBoundary() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "Content-Type: multipart/form-data;\r\n" +
            "Content-Length: 0\r\n" +
            "\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual((error as! ParseError), .invalidBoundary)
        }
    }

    func testContentLength() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Content-Length: 0\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.contentLength, 0)
        } catch {
            fail(String(describing: error))
        }
    }

    func testKeepAliveFalse() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Connection: Close\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertFalse(request.shouldKeepAlive)
        } catch {
            fail(String(describing: error))
        }
    }

    func testKeepAliveTrue() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Connection: Keep-Alive\r\n" +
                "Keep-Alive: 300\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertTrue(request.shouldKeepAlive)
            assertEqual(request.keepAlive, 300)
        } catch {
            fail(String(describing: error))
        }
    }

    func testTransferEncodingChunked() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Transfer-Encoding: chunked\r\n" +
                "\r\n" +
                "0\r\n")
            let request = try Request(from: stream)
            assertEqual(request.transferEncoding, [.chunked])
        } catch {
            fail(String(describing: error))
        }
    }

    func testCookies() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Cookie: username=tony\r\n" +
                "Cookie: lang=aurebesh\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.cookies, [
                Cookie(name: "username", value: "tony"),
                Cookie(name: "lang", value: "aurebesh")
            ])
        } catch {
            fail(String(describing: error))
        }
    }

    func testCookiesJoined() {
        do {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Cookie: username=tony; lang=aurebesh\r\n" +
                "\r\n")
            let request = try Request(from: stream)
            assertEqual(request.cookies, [
                Cookie(name: "username", value: "tony"),
                Cookie(name: "lang", value: "aurebesh")
            ])
        } catch {
            fail(String(describing: error))
        }
    }

    func testCookiesNoSpace() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "Cookie: username=tony;lang=aurebesh\r\n" +
            "\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidRequest)
        }
    }

    func testCookiesTrailingSemicolon() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "Cookie: username=tony;\r\n" +
            "\r\n")
        assertThrowsError(try Request(from: stream)) { error in
            assertEqual(error as? ParseError, .invalidRequest)
        }
    }

    func testEscaped() {
        do {
            let escapedUrl = "/%D0%BF%D1%83%D1%82%D1%8C" +
                "?%D0%BA%D0%BB%D1%8E%D1%87" +
                "=%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D0%B8%D0%B5" +
                "#%D1%84%D1%80%D0%B0%D0%B3%D0%BC%D0%B5%D0%BD%D1%82"
            let stream = InputByteStream("GET \(escapedUrl) HTTP/1.1\r\n\r\n")
            let request = try Request(from: stream)
            assertEqual(request.url, try URL("/путь?ключ=значение"))
            assertEqual(request.url.fragment, "фрагмент")
        } catch {
            fail(String(describing: error))
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
        ("testInvalidRequest", testInvalidRequest),
        ("testInvalidRequest2", testInvalidRequest2),
        ("testInvalidMethod", testInvalidMethod),
        ("testInvalidVersion", testInvalidVersion),
        ("testInvalidVersion2", testInvalidVersion2),
        ("testInvalidVersion3", testInvalidVersion3),
        ("testInvalidVersion4", testInvalidVersion4),
        ("testInvalidEnd", testInvalidEnd),
        ("testHostHeader", testHostHeader),
        ("testHostDomainHeader", testHostDomainHeader),
        ("testHostEncodedHeader", testHostEncodedHeader),
        ("testUserAgentHeader", testUserAgentHeader),
        ("testAcceptHeader",testAcceptHeader),
        ("testAcceptLanguageHeader",testAcceptLanguageHeader),
        ("testAcceptEncodingHeader",testAcceptEncodingHeader),
        ("testAcceptCharset",testAcceptCharset),
        ("testAcceptCharsetSpaceSeparator", testAcceptCharsetSpaceSeparator),
        ("testAuthorization", testAuthorization),
        ("testCustomHeader", testCustomHeader),
        ("testTwoHeaders", testTwoHeaders),
        ("testTwoHeadersOptionalSpaces", testTwoHeadersOptionalSpaces),
        ("testInvalidHeaderColon", testInvalidHeaderColon),
        ("testInvalidHeaderName", testInvalidHeaderName),
        ("testInvalidHeaderEnd", testInvalidHeaderEnd),
        ("testHeaderName", testHeaderName),
        ("testUnexpectedEnd", testUnexpectedEnd),
        ("testContentType", testContentType),
        ("testContentTypeCharset", testContentTypeCharset),
        ("testContentTypeEmptyCharset", testContentTypeEmptyCharset),
        ("testContentTypeBoundary", testContentTypeBoundary),
        ("testContentTypeEmptyBoundary", testContentTypeEmptyBoundary),
        ("testContentLength", testContentLength),
        ("testKeepAliveFalse", testKeepAliveFalse),
        ("testKeepAliveTrue", testKeepAliveTrue),
        ("testTransferEncodingChunked", testTransferEncodingChunked),
        ("testCookies", testCookies),
        ("testCookiesJoined", testCookiesJoined),
        ("testCookiesNoSpace", testCookiesNoSpace),
        ("testCookiesTrailingSemicolon", testCookiesTrailingSemicolon),
        ("testEscaped", testEscaped)
    ]
}

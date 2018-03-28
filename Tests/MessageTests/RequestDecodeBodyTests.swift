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

class RequestDecodeBodyTests: TestCase {
    func testContentLength() {
        scope {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Content-Length: 5\r\n" +
                "\r\n" +
                "Hello")
            let request = try Request(from: stream)
            assertEqual(request.contentLength, 5)
            assertEqual(request.string, "Hello")
        }
    }

    func testChunkedBody() {
        scope {
            let stream = InputByteStream(
                "GET / HTTP/1.1\r\n" +
                "Transfer-Encoding: chunked\r\n" +
                "\r\n" +
                "5\r\nHello\r\n" +
                "0\r\n\r\n")
            let request = try Request(from: stream)
            assertEqual(request.string, "Hello")
        }
    }

    func testChunkedBodyInvalidSizeSeparator() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "Transfer-Encoding: chunked\r\n" +
            "\r\n" +
            "5\rHello\r\n" +
            "0\r\n\r\n")
        scope {
            let request = try Request(from: stream)
            assertThrowsError(try request.readBytes()) { error in
                assertEqual(error as? ParseError, .invalidRequest)
            }
        }
    }

    func testChunkedBodyNoSizeSeparator() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "Transfer-Encoding: chunked\r\n" +
            "\r\n" +
            "5 Hello\r\n" +
            "0\r\n\r\n")
        scope {
            let request = try Request(from: stream)
            assertThrowsError(try request.readBytes()) { error in
                assertEqual(error as? ParseError, .invalidRequest)
            }
        }
    }

    func testChunkedMissingLineEnd() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "Transfer-Encoding: chunked\r\n" +
            "\r\n" +
            "5\r\nHello\r\n" +
            "0\r\n")
        scope {
            let request = try Request(from: stream)
            assertThrowsError(try request.readBytes()) { error in
                assertEqual(error as? ParseError, .unexpectedEnd)
            }
        }
    }

    func testChunkedInvalidBody() {
        let stream = InputByteStream(
            "GET / HTTP/1.1\r\n" +
            "Transfer-Encoding: chunked\r\n" +
            "\r\n" +
            "5\r\nHello")
        scope {
            let request = try Request(from: stream)
            assertThrowsError(try request.readBytes()) { error in
                assertEqual(error as? ParseError, .unexpectedEnd)
            }
        }
    }
}

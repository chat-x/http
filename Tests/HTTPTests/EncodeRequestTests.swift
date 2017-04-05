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

class EncodeRequestTests: TestCase {
    func testRequest() {
        let expected = "GET /test HTTP/1.1\r\n\r\n"
        let request = Request(method: .get, url: "/test")
        let result = String(bytes: request.bytes)
        assertEqual(result, expected)
    }

    func testUrlQuery() {
        let expected = "GET /test? HTTP/1.1\r\n\r\n"
        let request = Request(
            method: .get,
            url: URL(path: "/test", query: "?"))
        let result = String(bytes: request.bytes)
        assertEqual(result, expected)
    }


    static var allTests = [
        ("testRequest", testRequest),
        ("testUrlQuery", testUrlQuery),
    ]
}

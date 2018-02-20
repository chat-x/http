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

class RequestTests: TestCase {
    func testRequest() {
        let request = Request(url: "/", method: .get)
        assertEqual(request.method, .get)
        assertEqual(request.url.path, "/")
    }

    func testDefaultRequest() {
        let request = Request()
        assertEqual(request.method, .get)
        assertEqual(request.url.path, "/")
    }

    func testDefaultMethod() {
        let request = Request(url: "/")
        assertEqual(request.method, .get)
        assertEqual(request.url.path, "/")
    }

    func testDefaultURL() {
        let request = Request(method: .get)
        assertEqual(request.method, .get)
        assertEqual(request.url.path, "/")
    }

    func testFromString() {
        let request = Request(url: "/test?query=true")
        assertEqual(request.url.path, "/test")
        assertEqual(request.url.query, ["query" : "true"])
    }
}

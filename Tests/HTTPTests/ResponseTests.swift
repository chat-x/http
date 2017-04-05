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

class ResponseTests: TestCase {
    func testResponse() {
        let response = Response(status: .ok)
        assertEqual(response.status, .ok)
        assertNil(response.contentType)
    }

    func testDefaultStatus() {
        let response = Response()
        assertEqual(response.status, .ok)
        assertNil(response.contentType)
    }

    func testVersion() {
        let response = Response(version: .oneOne)
        assertEqual(response.version, .oneOne)
    }


    static var allTests = [
        ("testResponse", testResponse),
        ("testDefaultStatus", testDefaultStatus),
        ("testVersion", testVersion),
    ]
}

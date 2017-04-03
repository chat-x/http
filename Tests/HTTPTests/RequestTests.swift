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

class RequestTests: TestCase {
    func testRequest() {
        let request = Request(url: URL("/test"))
        assertNotNil(request)
        assert(request.url.path == "/test")
    }


    static var allTests = [
        ("testRequest", testRequest),
    ]
}

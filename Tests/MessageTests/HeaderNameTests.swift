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

class HeaderNameTests: TestCase {
    func testHeaderName() {
        let name = HeaderName("Content-Length")
        assertEqual(name, HeaderName("Content-Length"))
        assertEqual(name, HeaderName("content-length"))
    }

    func testHeaderNameDescription() {
        let name = HeaderName("Content-Length")
        assertEqual(name.description, "Content-Length")
    }


    static var allTests = [
        ("testHeaderName", testHeaderName),
        ("testHeaderNameDescription", testHeaderNameDescription)
    ]
}
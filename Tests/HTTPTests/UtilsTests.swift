/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import XCTest
@testable import HTTP

class UtilsTests: TestCase {
    func testString() {
        let bytes = ASCII("wuut")
        let buffer = UnsafeRawBufferPointer(start: bytes, count: bytes.count)
        assertEqual(String(bytes: bytes), "wuut")
        assertEqual(String(buffer: buffer), "wuut")
    }

    static var allTests = [
        ("testString", testString),
    ]
}

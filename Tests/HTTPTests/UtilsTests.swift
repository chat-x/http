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

class UtilsTests: TestCase {
    func testString() {
        let bytes = ASCII("string")
        let buffer = UnsafeRawBufferPointer(start: bytes, count: bytes.count)
        assertEqual(String(bytes: bytes), "string")
        assertEqual(String(buffer: buffer), "string")
    }

    func testUnsafeString() {
        let bytes = ASCII("string")
        let buffer = UnsafeRawBufferPointer(
            start: bytes,
            count: bytes.count - 1)
        assertEqual(String(buffer: buffer), "strin")
    }


    static var allTests = [
        ("testString", testString),
        ("testUnsafeString", testUnsafeString),
    ]
}

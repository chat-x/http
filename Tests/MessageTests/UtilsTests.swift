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

class UtilsTests: TestCase {
    func testDouble() {
        assertEqual(try Double(from: InputByteStream("0.1")), 0.1)
        assertEqual(try Double(from: InputByteStream("1.0")), 1.0)
        assertEqual(try Double(from: InputByteStream("0.7")), 0.7)
        assertEqual(try Double(from: InputByteStream("3.14")), 3.14)
        assertEqual(try Double(from: InputByteStream("42")), 42)
        assertEqual(try Double(from: InputByteStream("42.")), 42)
    }


    static var allTests = [
        ("testDouble", testDouble)
    ]
}

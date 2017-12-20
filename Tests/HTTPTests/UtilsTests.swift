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
    func streamWith(_ string: String) -> BufferedInputStream<InputByteStream> {
        let stream = InputByteStream([UInt8](string.utf8))
        return BufferedInputStream(baseStream: stream)
    }

    func testDouble() {
        assertEqual(try Double(from: streamWith("0.1")), 0.1)
        assertEqual(try Double(from: streamWith("1.0")), 1.0)
        assertEqual(try Double(from: streamWith("0.7")), 0.7)
        assertEqual(try Double(from: streamWith("3.14")), 3.14)
        assertEqual(try Double(from: streamWith("42")), 42)
        assertEqual(try Double(from: streamWith("42.")), 42)
    }


    static var allTests = [
        ("testDouble", testDouble)
    ]
}

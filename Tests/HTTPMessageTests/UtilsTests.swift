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
@testable import HTTPMessage

class UtilsTests: TestCase {

    func testString() {
        let bytes = ASCII("wuut")
        let slice = bytes.slice
        assertEqual(String(bytes: bytes), "wuut")
        assertEqual(String(slice: slice), "wuut")
    }

    func testSlice() {
        let bytes: [UInt8] = [1,2,3,4,5]
        let slice = bytes.slice
        assertTrue(bytes.elementsEqual(slice))
    }

    func testContains() {
        let bytes: [UInt8] = [1,2,3,4,5]
        let slice = bytes.slice
        assertTrue(slice.contains(other: [2,3,4]))
        assertFalse(slice.contains(other: [2,9,1]))
    }

    static var allTests = [
        ("testString", testString),
        ("testSlice", testSlice),
    ]
}

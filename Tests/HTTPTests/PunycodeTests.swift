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
import HTTP

class PunycodeTests: TestCase {
    func testEncode() {
        let encoded = Punycode.encode(domain: "привет.рф")
        assertEqual(encoded, "xn--b1agh1afp.xn--p1ai")
    }

    func testDecode() {
        let decoded = Punycode.decode(domain: "xn--b1agh1afp.xn--p1ai")
        assertEqual(decoded, "привет.рф")
    }

    func testEncodeMixedCase() {
        let encoded = Punycode.encode(domain: "Привет.рф")
        assertEqual(encoded, "xn--r0a2bjk3bp.xn--p1ai")
    }

    func testDecodeMixedCase() {
        let decoded = Punycode.decode(domain: "xn--r0a2bjk3bp.xn--p1ai")
        assertEqual(decoded, "Привет.рф")
    }

    func testEncodeMixedASCII() {
        let encoded = Punycode.encode(domain: "hello-мир.рф")
        assertEqual(encoded, "xn--hello--upf5a1b.xn--p1ai")
    }

    func testDecodeMixedASCII() {
        let decoded = Punycode.decode(domain: "xn--hello--upf5a1b.xn--p1ai")
        assertEqual(decoded, "hello-мир.рф")
    }


    static var allTests = [
        ("testEncode", testEncode),
        ("testDecode", testDecode),
        ("testEncodeMixedCase", testEncodeMixedCase),
        ("testDecodeMixedCase", testDecodeMixedCase),
        ("testEncodeMixedASCII", testEncodeMixedCase),
        ("testDecodeMixedASCII", testEncodeMixedCase)
    ]
}

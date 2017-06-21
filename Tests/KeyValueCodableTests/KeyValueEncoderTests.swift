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
@testable import KeyValueCodable

class KeyValueEncoderTests: TestCase {
    func testKeyedEncoder() {
        struct Model: Encodable {
            let first: String
            let second: String
        }
        do {
            let encoder = KeyValueEncoder()
            let values = try encoder.encode(Model(first: "one", second: "two"))

            assertEqual(values["first"], "one")
            assertEqual(values["second"], "two")
        } catch {
            print(String(describing: error))
        }
    }

    func testSingleValueEncoder() {
        do {
            let encoder = KeyValueEncoder()
            let values = try encoder.encode(42)

            assertEqual(values["integer"], "42")
        } catch {
            print(String(describing: error))
        }
    }


    static var allTests = [
        ("testKeyedEncoder", testKeyedEncoder),
        ("testSingleValueEncoder", testSingleValueEncoder)
    ]
}

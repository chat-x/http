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

class KeyValueEncoderTests: TestCase {
    func testKeyedEncoder() {
        scope {
            struct Model: Encodable {
                let first: String
                let second: String
            }
            let encoder = KeyValueEncoder()
            let values = try encoder.encode(Model(first: "one", second: "two"))
            assertEqual(values["first"], "one")
            assertEqual(values["second"], "two")
        }
    }

    func testSingleValueEncoder() {
        scope {
            let encoder = KeyValueEncoder()
            let values = try encoder.encode(42)
            assertEqual(values["integer"], "42")
        }
    }
}

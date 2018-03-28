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

class KeyValueDecoderTests: TestCase {
    func testKeyedDecoder() {
        scope {
            let values = ["first":"one","second":"two"]
            struct Model: Decodable {
                let first: String
                let second: String
            }
            let object = try KeyValueDecoder().decode(Model.self, from: values)
            assertEqual(object.first, "one")
            assertEqual(object.second, "two")
        }
    }

    func testSingleValueDecoder() {
        scope {
            let value = ["integer":"42"]
            let integer = try KeyValueDecoder().decode(Int.self, from: value)
            assertEqual(integer, 42)
        }
    }
}

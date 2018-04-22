/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/

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

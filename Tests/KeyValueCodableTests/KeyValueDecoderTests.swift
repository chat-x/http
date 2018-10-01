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

class KeyValueDecoderTests: TestCase {
    func testKeyedDecoder() {
        scope {
            let values = ["first":"one","second":"two"]
            struct Model: Decodable {
                let first: String
                let second: String?
            }
            let object = try Model(from: KeyValueDecoder(values))
            assertEqual(object.first, "one")
            assertEqual(object.second, "two")
        }
    }

    func testSingleValueDecoder() {
        scope {
            let value = ["integer":"42"]
            let integer = try Int(from: KeyValueDecoder(value))
            assertEqual(integer, 42)
        }
    }
}

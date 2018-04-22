/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************
 *  This file contains code that has not yet been described                   *
 ******************************************************************************/

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
}

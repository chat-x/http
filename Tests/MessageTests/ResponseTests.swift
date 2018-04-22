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

class ResponseTests: TestCase {
    func testResponse() {
        let response = Response(status: .ok)
        assertEqual(response.status, .ok)
        assertNil(response.contentType)
    }

    func testDefaultStatus() {
        let response = Response()
        assertEqual(response.status, .ok)
        assertNil(response.contentType)
    }

    func testVersion() {
        let response = Response(version: .oneOne)
        assertEqual(response.version, .oneOne)
    }
}

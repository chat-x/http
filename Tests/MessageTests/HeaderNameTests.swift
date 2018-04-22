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

class HeaderNameTests: TestCase {
    func testHeaderName() {
        let name = HeaderName("Content-Length")
        assertEqual(name, HeaderName("Content-Length"))
        assertEqual(name, HeaderName("content-length"))
    }

    func testHeaderNameDescription() {
        let name = HeaderName("Content-Length")
        assertEqual(name.description, "Content-Length")
    }
}

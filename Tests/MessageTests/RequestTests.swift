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

class RequestTests: TestCase {
    func testRequest() {
        let request = Request(url: "/", method: .get)
        assertEqual(request.method, .get)
        assertEqual(request.url.path, "/")
    }

    func testDefaultRequest() {
        let request = Request()
        assertEqual(request.method, .get)
        assertEqual(request.url.path, "/")
    }

    func testDefaultMethod() {
        let request = Request(url: "/")
        assertEqual(request.method, .get)
        assertEqual(request.url.path, "/")
    }

    func testDefaultURL() {
        let request = Request(method: .get)
        assertEqual(request.method, .get)
        assertEqual(request.url.path, "/")
    }

    func testFromString() {
        let request = Request(url: "/test?query=true")
        assertEqual(request.url.path, "/test")
        assertEqual(request.url.query, ["query" : "true"])
    }
}

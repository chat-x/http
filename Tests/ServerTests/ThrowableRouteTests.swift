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

extension String: Swift.Error {}

func makeMistake() throws {
    throw "expected failure"
}

class ThrowableRouteTests: TestCase {
    func testInternalServerError() {
        let router = Router(middleware: [ErrorHandlerMiddleware.self])

        router.route(get: "/") {
            try makeMistake()
            return Response(status: .ok)
        }

        let request = Request(url: "/", method: .get)
        let response = router.handleRequest(request)
        assertEqual(response?.status, .internalServerError)
    }

    func testNotFound() {
        let router = Router(middleware: [ErrorHandlerMiddleware.self])

        router.route(get: "/") {
            throw Error.notFound
        }

        let request = Request(url: "/", method: .get)
        let response = router.handleRequest(request)
        assertEqual(response?.status, .notFound)
    }
}

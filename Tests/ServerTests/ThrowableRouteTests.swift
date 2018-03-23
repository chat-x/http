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

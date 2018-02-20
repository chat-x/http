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
    class Server: RouterProtocol {
        let bufferSize: Int = 4096

        @_versioned
        var router = Router(middleware: [ErrorHandlerMiddleware.self])

        var middleware: [Middleware.Type] {
            get { return router.middleware }
            set { router.middleware = newValue }
        }

        public func registerRoute(
            path: String,
            methods: Router.MethodSet,
            middleware: [Middleware.Type],
            handler: @escaping RequestHandler
        ) {
            router.registerRoute(
                path: path,
                methods: methods,
                middleware: middleware,
                handler: handler)
        }

        public func findHandler(
            path: String,
            methods: Router.MethodSet
        ) -> RequestHandler? {
            return router.findHandler(path: path, methods: methods)
        }
    }

    func testInternalServerError() {
        let server = Server()

        server.route(get: "/") {
            try makeMistake()
            return Response(status: .ok)
        }

        let request = Request(url: "/", method: .get)
        let response = server.handleRequest(request)
        assertEqual(response?.status, .internalServerError)
    }

    func testNotFound() {
        let server = Server()

        server.route(get: "/") {
            throw Error.notFound
        }

        let request = Request(url: "/", method: .get)
        let response = server.handleRequest(request)
        assertEqual(response?.status, .notFound)
    }

    static var allTests = [
        ("testInternalServerError", testInternalServerError),
        ("testNotFound", testNotFound),
    ]
}

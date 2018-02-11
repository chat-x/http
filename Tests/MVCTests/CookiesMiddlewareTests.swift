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

class CookiesMiddlewareTests: TestCase {
    func testMiddleware() {
        final class TestController: Controller, InjectService {
            static var middleware: [ControllerMiddleware.Type] {
                return [CookieMiddleware.self]
            }

            static func setup(router: ControllerRouter<TestController>) throws {
                router.route(get: "/first", to: first)
                router.route(get: "/second", to: second)
            }

            let context: Context

            init(_ context: Context) {
                self.context = context
            }

            func first() -> String {
                context.cookies["cookie-name"] = "cookie-value"
                return "ok"
            }

            func second() -> String? {
                return context.cookies["cookie-name"]
            }
        }

        do {
            try Services.shared.register(
                singleton: InMemoryCookieStorage.self,
                as: CookieStorage.self)

            let application = Application()
            try application.addController(TestController.self)

            let firstRequest = Request(url: "/first", method: .get)
            let firstResponse = application.handleRequest(firstRequest)
            assertEqual(firstResponse?.setCookie.count, 1)
            guard let setCookie = firstResponse?.setCookie.first else {
                return
            }
            assertEqual(setCookie.cookie.name, "tris-cookies")
            assertFalse(setCookie.cookie.value.isEmpty)

            let secondRequest = Request(url: "/second", method: .get)
            var secondResponse = application.handleRequest(secondRequest)
            assertEqual(secondResponse?.status, .noContent)
            assertNil(secondResponse?.string)

            secondRequest.cookies.append(setCookie.cookie)
            secondResponse = application.handleRequest(secondRequest)
            assertEqual(secondResponse?.string, "cookie-value")

        } catch {
            fail(String(describing: error))
        }
    }


    static var allTests = [
        ("testMiddleware", testMiddleware),
    ]
}

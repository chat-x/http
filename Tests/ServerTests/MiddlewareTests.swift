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
import Network
import Dispatch
import Foundation
import AsyncDispatch

@testable import HTTP

class MiddlewareTests: TestCase {
    override func setUp() {
        AsyncDispatch().registerGlobal()
    }

    func testMiddleware() {
        let semaphore = DispatchSemaphore(value: 0)

        struct TestMiddleware: Middleware {
            public static func createMiddleware(
                for handler: @escaping RequestHandler
            ) -> RequestHandler {
                return { request in
                    let response = try handler(request)
                    response.status = .ok
                    response.headers["Custom-Header"] = "Middleware"
                    return response
                }
            }
        }

        async.task {
            do {
                let server = try HTTP.Server(host: "127.0.0.1", port: 4201)

                server.route(
                    get: "/middleware",
                    middleware: [TestMiddleware.self]
                ) {
                    return Response(status: .internalServerError)
                }

                semaphore.signal()
                try server.start()
            } catch {
                fail(String(describing: error))
            }
            async.loop.terminate()
        }

        semaphore.wait()

        async.task {
            do {
                let request = "GET /middleware HTTP/1.1\r\n\r\n"
                let expected =
                    "HTTP/1.1 200 OK\r\n" +
                    "Content-Length: 0\r\n" +
                    "Custom-Header: Middleware\r\n" +
                    "\r\n"
                var buffer = [UInt8](repeating: 0, count: 1000)

                let socket = try Socket()
                try socket.connect(to: "127.0.0.1", port: 4201)
                _ = try socket.send(bytes: [UInt8](request.utf8))
                _ = try socket.receive(to: &buffer)
                let response = String(cString: &buffer)

                assertEqual(response, expected)
            } catch {
                fail(String(describing: error))
            }
            async.loop.terminate()
        }

        async.loop.run()
    }

    func testMiddlewareOrder() {
        let semaphore = DispatchSemaphore(value: 0)

        struct FirstMiddleware: Middleware {
            public static func createMiddleware(
                for handler: @escaping RequestHandler
            ) -> RequestHandler {
                return { request in
                    let response = try handler(request)
                    response.headers["Middleware"] = "first"
                    response.headers["FirstMiddleware"] = "true"
                    return response
                }
            }
        }

        struct SecondMiddleware: Middleware {
            public static func createMiddleware(
                for handler: @escaping RequestHandler
            ) -> RequestHandler {
                return { request in
                    let response = try handler(request)
                    response.headers["Middleware"] = "second"
                    response.headers["SecondMiddleware"] = "true"
                    return response
                }
            }
        }

        async.task {
            do {
                let server = try HTTP.Server(host: "127.0.0.1", port: 4202)

                server.route(
                    get: "/middleware",
                    middleware: [FirstMiddleware.self, SecondMiddleware.self]
                ) {
                    return Response(status: .ok)
                }

                semaphore.signal()
                try server.start()
            } catch {
                fail(String(describing: error))
            }
            async.loop.terminate()
        }

        semaphore.wait()

        async.task {
            do {
                let request = "GET /middleware HTTP/1.1\r\n\r\n"
                var buffer = [UInt8](repeating: 0, count: 1000)

                let socket = try Socket()
                try socket.connect(to: "127.0.0.1", port: 4202)
                _ = try socket.send(bytes: [UInt8](request.utf8))
                _ = try socket.receive(to: &buffer)
                let response = String(cString: &buffer)

                let lines = response.components(separatedBy: "\r\n")

                let firstMiddleware = lines.first(where: {
                    return $0.hasPrefix("FirstMiddleware")
                })
                let secondMiddleware = lines.first(where: {
                    return $0.hasPrefix("SecondMiddleware")
                })
                let middleware = lines.first(where: {
                    return $0.hasPrefix("Middleware")
                })

                assertEqual(firstMiddleware, "FirstMiddleware: true")
                assertEqual(secondMiddleware, "SecondMiddleware: true")
                assertEqual(middleware, "Middleware: first")
            } catch {
                fail(String(describing: error))
            }
            async.loop.terminate()
        }

        async.loop.run()
    }


    static var allTests = [
        ("testMiddleware", testMiddleware),
        ("testMiddlewareOrder", testMiddlewareOrder),
    ]
}

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
@testable import Server
import Network

class ServerTests: TestCase {
    func testServer() {
        let condition = AtomicCondition()
        let async = TestAsync()

        async.task {
            do {
                let server =
                    try Server(host: "127.0.0.1", port: 4001, async: async)

                server.route(get: "/test") {
                    return Response(status: .ok)
                }

                condition.signal()
                try server.start()
            } catch {
                fail(String(describing: error))
                async.breakLoop()
            }
        }

        condition.wait()

        async.task {
            do {
                let request = "GET /test HTTP/1.1\r\n\r\n"
                let expected = "HTTP/1.1 200 OK\r\nContent-Length: 0\r\n\r\n"
                var buffer = [UInt8](repeating: 0, count: 100)

                let socket = try Socket(awaiter: async.awaiter)
                try socket.connect(to: "127.0.0.1", port: 4001)
                _ = try socket.send(bytes: [UInt8](request.utf8))
                _ = try socket.receive(to: &buffer)
                let response = String(cString: &buffer)

                assertEqual(response, expected)

                async.breakLoop()
            } catch {
                fail(String(describing: error))
                async.breakLoop()
            }
        }

        async.loop.run()
    }


    static var allTests = [
        ("testServer", testServer),
    ]
}

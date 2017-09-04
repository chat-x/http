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
import HTTP
import Network
@testable import Client

class ClientTests: TestCase {
    override func setUp() {
        if async == nil {
            TestAsync().registerGlobal()
        }
    }

    func testClient() {
        let condition = AtomicCondition()

        async.task {
            do {
                let expected = "GET / HTTP/1.1\r\n\r\n"
                let result = "HTTP/1.1 200 OK\r\n\r\n"
                var buffer = [UInt8](repeating: 0, count: 100)

                let socket = try Socket()
                    .bind(to: "127.0.0.1", port: 5001)
                    .listen()

                condition.signal()

                let client = try socket.accept()
                let count = try client.receive(to: &buffer)
                _ = try client.send(bytes: [UInt8](result.utf8))

                let request = String(ascii: [UInt8](buffer[..<count]))
                assertEqual(request, expected)
            } catch {
                (async.loop as! TestAsyncLoop).stop()
                fail(String(describing: error))
            }
        }

        condition.wait()

        async.task {
            do {
                let request = Request()

                let client = try Client()
                try client.connect(to: URL("http://127.0.0.1:5001/"))
                let response = try client.makeRequest(request)

                assertEqual(response.status, .ok)
                assertNil(response.body)

                (async.loop as! TestAsyncLoop).stop()
            } catch {
                (async.loop as! TestAsyncLoop).stop()
                fail(String(describing: error))
            }
        }

        async.loop.run()
    }


    static var allTests = [
        ("testClient", testClient),
    ]
}

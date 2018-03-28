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
import Stream
@testable import HTTP

class RequestEncodeBodyTests: TestCase {
    func testJsonInitializer() {
        scope {
            let expected =
                "POST / HTTP/1.1\r\n" +
                "Content-Type: application/json\r\n" +
                "Content-Length: 27\r\n" +
                "\r\n" +
                "{\"message\":\"Hello, World!\"}"
            let values = ["message": "Hello, World!"]
            let request = try Request(url: "/", method: .post, body: values)
            assertEqual(try request.encode(), expected)
        }
    }

    func testFormURLEncodedInitializer() {
        scope {
            let expected =
                "POST / HTTP/1.1\r\n" +
                "Content-Type: application/x-www-form-urlencoded\r\n" +
                "Content-Length: 23\r\n" +
                "\r\n" +
                "message=Hello,%20World!"
            struct Query: Encodable {
                let message = "Hello, World!"
            }
            let request = try Request(
                url: "/",
                method: .post,
                body: Query(),
                contentType: .formURLEncoded)
            assertEqual(try request.encode(), expected)
        }
    }
}

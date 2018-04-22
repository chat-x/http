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

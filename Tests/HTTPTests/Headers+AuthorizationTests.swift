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

class HeadersAuthorizationTests: TestCase {
    func testBasic() {
        let bytes = ASCII("Basic sYbe7s3c73Tt0k3n")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))
        let basic = try? Request.Authorization(from: stream)
        assertEqual(basic, .basic(credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testBearer() {
        let bytes = ASCII("Bearer sYbe7s3c73Tt0k3n")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))
        let bearer = try? Request.Authorization(from: stream)
        assertEqual(bearer, .bearer(credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testToken() {
        let bytes = ASCII("Token sYbe7s3c73Tt0k3n")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))
        let token = try? Request.Authorization(from: stream)
        assertEqual(token, .token(credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testCustom() {
        let bytes = ASCII("Custom sYbe7s3c73Tt0k3n")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))
        let custom = try? Request.Authorization(from: stream)
        assertEqual(custom, .custom(
            scheme: "Custom", credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testLowercased() {
        let bytes = ASCII("token sYbe7s3c73Tt0k3n")
        let stream = BufferedInputStream(baseStream: InputByteStream(bytes))
        let token = try? Request.Authorization(from: stream)
        assertEqual(token, .token(credentials: "sYbe7s3c73Tt0k3n"))
    }


    static var allTests = [
        ("testBasic", testBasic),
        ("testBearer", testBearer),
        ("testToken", testToken),
        ("testCustom", testCustom),
        ("testLowercased", testLowercased),
    ]
}

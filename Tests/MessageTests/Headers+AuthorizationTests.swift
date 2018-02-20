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
        let stream = InputByteStream("Basic sYbe7s3c73Tt0k3n")
        let basic = try? Request.Authorization(from: stream)
        assertEqual(basic, .basic(credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testBearer() {
        let stream = InputByteStream("Bearer sYbe7s3c73Tt0k3n")
        let bearer = try? Request.Authorization(from: stream)
        assertEqual(bearer, .bearer(credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testToken() {
        let stream = InputByteStream("Token sYbe7s3c73Tt0k3n")
        let token = try? Request.Authorization(from: stream)
        assertEqual(token, .token(credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testCustom() {
        let stream = InputByteStream("Custom sYbe7s3c73Tt0k3n")
        let custom = try? Request.Authorization(from: stream)
        assertEqual(custom, .custom(
            scheme: "Custom", credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testLowercased() {
        let stream = InputByteStream("token sYbe7s3c73Tt0k3n")
        let token = try? Request.Authorization(from: stream)
        assertEqual(token, .token(credentials: "sYbe7s3c73Tt0k3n"))
    }
}

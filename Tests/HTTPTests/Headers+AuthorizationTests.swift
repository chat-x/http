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

class HeadersTests: TestCase {
    func testAuthorizationBasic() {
        let bytes = ASCII("Basic sYbe7s3c73Tt0k3n")
        let buffer = UnsafeRawBufferPointer(start: bytes, count: bytes.count)
        let basic = try? Request.Authorization(from: buffer[...])
        assertEqual(basic, .basic(credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testAuthorizationBearer() {
        let bytes = ASCII("Bearer sYbe7s3c73Tt0k3n")
        let buffer = UnsafeRawBufferPointer(start: bytes, count: bytes.count)
        let bearer = try? Request.Authorization(from: buffer[...])
        assertEqual(bearer, .bearer(credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testAuthorizationToken() {
        let bytes = ASCII("Token sYbe7s3c73Tt0k3n")
        let buffer = UnsafeRawBufferPointer(start: bytes, count: bytes.count)
        let token = try? Request.Authorization(from: buffer[...])
        assertEqual(token, .token(credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testAuthorizationCustom() {
        let bytes = ASCII("Custom sYbe7s3c73Tt0k3n")
        let buffer = UnsafeRawBufferPointer(start: bytes, count: bytes.count)
        let custom = try? Request.Authorization(from: buffer[...])
        assertEqual(custom, .custom(
            scheme: "Custom", credentials: "sYbe7s3c73Tt0k3n"))
    }

    func testAuthorizationLowercased() {
        let bytes = ASCII("token sYbe7s3c73Tt0k3n")
        let buffer = UnsafeRawBufferPointer(start: bytes, count: bytes.count)
        let token = try? Request.Authorization(from: buffer[...])
        assertEqual(token, .token(credentials: "sYbe7s3c73Tt0k3n"))
    }


    static var allTests = [
        ("testAuthorizationBasic", testAuthorizationBasic),
        ("testAuthorizationBearer", testAuthorizationBearer),
        ("testAuthorizationToken", testAuthorizationToken),
        ("testAuthorizationCustom", testAuthorizationCustom),
        ("testAuthorizationLowercased", testAuthorizationLowercased),
    ]
}

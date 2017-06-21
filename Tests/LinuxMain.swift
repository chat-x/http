/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import XCTest
@testable import HTTPTests
@testable import ServerTests
@testable import ClientTests
@testable import FunctionalTests
@testable import KeyValueCodableTests

XCTMain([
    // HTTPTests
    testCase(RequestTests.allTests),
    testCase(ResponseTests.allTests),
    testCase(EncodeRequestTests.allTests),
    testCase(EncodeResponseTests.allTests),
    testCase(DecodeRequestTests.allTests),
    testCase(DecodeResponseTests.allTests),
    testCase(NginxTests.allTests),
    testCase(UtilsTests.allTests),
    // ServerTests
    testCase(MiddlewareTests.allTests),
    testCase(RouterTests.allTests),
    testCase(ServerTests.allTests),
    testCase(ThrowableRouteTests.allTests),
    // ClientTests
    testCase(ClientTests.allTests),
    // KeyValueCodableTests
    testCase(KeyValueDecoderTests.allTests),
    testCase(KeyValueEncoderTests.allTests),
    // FunctionalTests
    testCase(FunctionalTests.allTests)
])

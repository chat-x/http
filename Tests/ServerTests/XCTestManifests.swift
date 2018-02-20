import XCTest

extension ApplicationTests {
    static let __allTests = [
        ("testApplication", testApplication),
        ("testApplicationBasePath", testApplicationBasePath),
        ("testApplicationMiddleware", testApplicationMiddleware),
    ]
}

extension MiddlewareTests {
    static let __allTests = [
        ("testMiddleware", testMiddleware),
        ("testMiddlewareOrder", testMiddlewareOrder),
    ]
}

extension RouterTests {
    static let __allTests = [
        ("testAllVoid", testAllVoid),
        ("testGetModel", testGetModel),
        ("testGetRequest", testGetRequest),
        ("testGetRequestModel", testGetRequestModel),
        ("testGetRequestURLMatch", testGetRequestURLMatch),
        ("testGetRequestURLMatchModel", testGetRequestURLMatchModel),
        ("testGetURLMatch", testGetURLMatch),
        ("testGetURLMatchModel", testGetURLMatchModel),
        ("testMethodsVoid", testMethodsVoid),
        ("testPostModel", testPostModel),
        ("testPostRequest", testPostRequest),
        ("testPostRequestModel", testPostRequestModel),
        ("testPostRequestURLMatch", testPostRequestURLMatch),
        ("testPostRequestURLMatchModel", testPostRequestURLMatchModel),
        ("testPostURLMatch", testPostURLMatch),
        ("testPostURLMatchModel", testPostURLMatchModel),
        ("testUnicodeRoute", testUnicodeRoute),
    ]
}

extension ServerTests {
    static let __allTests = [
        ("testBufferSize", testBufferSize),
        ("testDescription", testDescription),
        ("testExpect", testExpect),
        ("testServer", testServer),
    ]
}

extension ThrowableRouteTests {
    static let __allTests = [
        ("testInternalServerError", testInternalServerError),
        ("testNotFound", testNotFound),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ApplicationTests.__allTests),
        testCase(MiddlewareTests.__allTests),
        testCase(RouterTests.__allTests),
        testCase(ServerTests.__allTests),
        testCase(ThrowableRouteTests.__allTests),
    ]
}
#endif

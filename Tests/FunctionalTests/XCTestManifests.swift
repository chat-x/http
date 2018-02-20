import XCTest

extension FunctionalTests {
    static let __allTests = [
        ("testAll", testAll),
        ("testDelete", testDelete),
        ("testFormEncoded", testFormEncoded),
        ("testGet", testGet),
        ("testHead", testHead),
        ("testJson", testJson),
        ("testOptions", testOptions),
        ("testPost", testPost),
        ("testPut", testPut),
        ("testRequest", testRequest),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FunctionalTests.__allTests),
    ]
}
#endif

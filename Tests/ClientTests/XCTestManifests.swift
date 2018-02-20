import XCTest

extension ClientTests {
    static let __allTests = [
        ("testDeflate", testDeflate),
        ("testGZip", testGZip),
        ("testInitializer", testInitializer),
        ("testRequest", testRequest),
        ("testURLInitializer", testURLInitializer),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ClientTests.__allTests),
    ]
}
#endif

import XCTest

extension KeyValueDecoderTests {
    static let __allTests = [
        ("testKeyedDecoder", testKeyedDecoder),
        ("testSingleValueDecoder", testSingleValueDecoder),
    ]
}

extension KeyValueEncoderTests {
    static let __allTests = [
        ("testKeyedEncoder", testKeyedEncoder),
        ("testSingleValueEncoder", testSingleValueEncoder),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(KeyValueDecoderTests.__allTests),
        testCase(KeyValueEncoderTests.__allTests),
    ]
}
#endif

import XCTest

extension ChunkedStreamTests {
    static let __allTests = [
        ("testInputStream", testInputStream),
        ("testInputStreamMultiline", testInputStreamMultiline),
        ("testOutputStream", testOutputStream),
        ("testOutputStreamMultiline", testOutputStreamMultiline),
        ("testSmallerBufferSize", testSmallerBufferSize),
    ]
}

extension HeaderNameTests {
    static let __allTests = [
        ("testHeaderName", testHeaderName),
        ("testHeaderNameDescription", testHeaderNameDescription),
    ]
}

extension HeadersAuthorizationTests {
    static let __allTests = [
        ("testBasic", testBasic),
        ("testBearer", testBearer),
        ("testCustom", testCustom),
        ("testLowercased", testLowercased),
        ("testToken", testToken),
    ]
}

extension NginxTests {
    static let __allTests = [
        ("testChankedAllYourBase", testChankedAllYourBase),
        ("testCurlGet", testCurlGet),
        ("testFirefoxGet", testFirefoxGet),
    ]
}

extension PunycodeTests {
    static let __allTests = [
        ("testDecode", testDecode),
        ("testDecodeMixedASCII", testDecodeMixedASCII),
        ("testDecodeMixedCase", testDecodeMixedCase),
        ("testEncode", testEncode),
        ("testEncodeMixedASCII", testEncodeMixedASCII),
        ("testEncodeMixedCase", testEncodeMixedCase),
    ]
}

extension RequestDecodeBodyTests {
    static let __allTests = [
        ("testChunkedBody", testChunkedBody),
        ("testChunkedBodyInvalidSizeSeparator", testChunkedBodyInvalidSizeSeparator),
        ("testChunkedBodyNoSizeSeparator", testChunkedBodyNoSizeSeparator),
        ("testChunkedInvalidBody", testChunkedInvalidBody),
        ("testChunkedMissingLineEnd", testChunkedMissingLineEnd),
        ("testContentLength", testContentLength),
    ]
}

extension RequestDecodeTests {
    static let __allTests = [
        ("testAcceptCharset", testAcceptCharset),
        ("testAcceptCharsetSpaceSeparator", testAcceptCharsetSpaceSeparator),
        ("testAcceptEncodingHeader", testAcceptEncodingHeader),
        ("testAcceptHeader", testAcceptHeader),
        ("testAcceptLanguageHeader", testAcceptLanguageHeader),
        ("testAuthorization", testAuthorization),
        ("testContentLength", testContentLength),
        ("testContentType", testContentType),
        ("testContentTypeBoundary", testContentTypeBoundary),
        ("testContentTypeCharset", testContentTypeCharset),
        ("testContentTypeEmptyBoundary", testContentTypeEmptyBoundary),
        ("testContentTypeEmptyCharset", testContentTypeEmptyCharset),
        ("testCookies", testCookies),
        ("testCookiesJoined", testCookiesJoined),
        ("testCookiesNoSpace", testCookiesNoSpace),
        ("testCookiesTrailingSemicolon", testCookiesTrailingSemicolon),
        ("testCustomHeader", testCustomHeader),
        ("testDelete", testDelete),
        ("testEscaped", testEscaped),
        ("testExpect", testExpect),
        ("testGet", testGet),
        ("testHead", testHead),
        ("testHeaderName", testHeaderName),
        ("testHostDomainHeader", testHostDomainHeader),
        ("testHostEncodedHeader", testHostEncodedHeader),
        ("testHostHeader", testHostHeader),
        ("testInvalidEnd", testInvalidEnd),
        ("testInvalidHeaderColon", testInvalidHeaderColon),
        ("testInvalidHeaderEnd", testInvalidHeaderEnd),
        ("testInvalidHeaderName", testInvalidHeaderName),
        ("testInvalidMethod", testInvalidMethod),
        ("testInvalidRequest", testInvalidRequest),
        ("testInvalidRequest2", testInvalidRequest2),
        ("testInvalidVersion", testInvalidVersion),
        ("testInvalidVersion2", testInvalidVersion2),
        ("testInvalidVersion3", testInvalidVersion3),
        ("testInvalidVersion4", testInvalidVersion4),
        ("testKeepAliveFalse", testKeepAliveFalse),
        ("testKeepAliveTrue", testKeepAliveTrue),
        ("testPost", testPost),
        ("testPut", testPut),
        ("testTransferEncodingChunked", testTransferEncodingChunked),
        ("testTwoHeaders", testTwoHeaders),
        ("testTwoHeadersOptionalSpaces", testTwoHeadersOptionalSpaces),
        ("testUnexpectedEnd", testUnexpectedEnd),
        ("testUrl", testUrl),
        ("testUserAgentHeader", testUserAgentHeader),
        ("testVersion", testVersion),
    ]
}

extension RequestEncodeBodyTests {
    static let __allTests = [
        ("testFormURLEncodedInitializer", testFormURLEncodedInitializer),
        ("testJsonInitializer", testJsonInitializer),
    ]
}

extension RequestEncodeTests {
    static let __allTests = [
        ("testAccept", testAccept),
        ("testAcceptCharset", testAcceptCharset),
        ("testAcceptEncoding", testAcceptEncoding),
        ("testAcceptLanguage", testAcceptLanguage),
        ("testAuthorization", testAuthorization),
        ("testConnection", testConnection),
        ("testContentLength", testContentLength),
        ("testContentType", testContentType),
        ("testCookie", testCookie),
        ("testCustomHeaders", testCustomHeaders),
        ("testEscaped", testEscaped),
        ("testHost", testHost),
        ("testHostDomain", testHostDomain),
        ("testHostEncoded", testHostEncoded),
        ("testKeepAlive", testKeepAlive),
        ("testRequest", testRequest),
        ("testTransferEncoding", testTransferEncoding),
        ("testUrl", testUrl),
        ("testUrlQueryGet", testUrlQueryGet),
        ("testUrlQueryPost", testUrlQueryPost),
        ("testUserAgent", testUserAgent),
    ]
}

extension RequestTests {
    static let __allTests = [
        ("testDefaultMethod", testDefaultMethod),
        ("testDefaultRequest", testDefaultRequest),
        ("testDefaultURL", testDefaultURL),
        ("testFromString", testFromString),
        ("testRequest", testRequest),
    ]
}

extension ResponseDecodeBodyTests {
    static let __allTests = [
        ("testBytesResponse", testBytesResponse),
        ("testChunked", testChunked),
        ("testHtmlResponse", testHtmlResponse),
        ("testJsonResponse", testJsonResponse),
        ("testStringResponse", testStringResponse),
        ("testZeroContentLenght", testZeroContentLenght),
    ]
}

extension ResponseDecodeTests {
    static let __allTests = [
        ("testBad", testBad),
        ("testConnection", testConnection),
        ("testContentEncoding", testContentEncoding),
        ("testContentLength", testContentLength),
        ("testContentType", testContentType),
        ("testCustomHeader", testCustomHeader),
        ("testInternalServerError", testInternalServerError),
        ("testMoved", testMoved),
        ("testNotFound", testNotFound),
        ("testOk", testOk),
        ("testSetCookie", testSetCookie),
        ("testSetCookieDomain", testSetCookieDomain),
        ("testSetCookieExpires", testSetCookieExpires),
        ("testSetCookieHttpOnly", testSetCookieHttpOnly),
        ("testSetCookieManyValues", testSetCookieManyValues),
        ("testSetCookieMaxAge", testSetCookieMaxAge),
        ("testSetCookiePath", testSetCookiePath),
        ("testSetCookieSecure", testSetCookieSecure),
        ("testTransferEncoding", testTransferEncoding),
        ("testUnauthorized", testUnauthorized),
    ]
}

extension ResponseEncodeBodyTests {
    static let __allTests = [
        ("testBytesResponse", testBytesResponse),
        ("testHtmlResponse", testHtmlResponse),
        ("testJsonResponse", testJsonResponse),
        ("testStringResponse", testStringResponse),
        ("testUrlFormEncodedResponse", testUrlFormEncodedResponse),
    ]
}

extension ResponseEncodeTests {
    static let __allTests = [
        ("testBad", testBad),
        ("testConnection", testConnection),
        ("testContentEncoding", testContentEncoding),
        ("testContentType", testContentType),
        ("testCustomHeader", testCustomHeader),
        ("testInternalServerError", testInternalServerError),
        ("testMoved", testMoved),
        ("testNotFound", testNotFound),
        ("testOk", testOk),
        ("testResponseHasContentLenght", testResponseHasContentLenght),
        ("testSetCookie", testSetCookie),
        ("testSetCookieDomain", testSetCookieDomain),
        ("testSetCookieExpires", testSetCookieExpires),
        ("testSetCookieHttpOnly", testSetCookieHttpOnly),
        ("testSetCookieManyValues", testSetCookieManyValues),
        ("testSetCookieMaxAge", testSetCookieMaxAge),
        ("testSetCookiePath", testSetCookiePath),
        ("testSetCookieSecure", testSetCookieSecure),
        ("testTransferEncoding", testTransferEncoding),
        ("testUnauthorized", testUnauthorized),
    ]
}

extension ResponseTests {
    static let __allTests = [
        ("testDefaultStatus", testDefaultStatus),
        ("testResponse", testResponse),
        ("testVersion", testVersion),
    ]
}

extension URLTests {
    static let __allTests = [
        ("testAbsoluteString", testAbsoluteString),
        ("testDescription", testDescription),
        ("testFragment", testFragment),
        ("testHost", testHost),
        ("testInvalidScheme", testInvalidScheme),
        ("testPath", testPath),
        ("testQuery", testQuery),
        ("testScheme", testScheme),
        ("testUnicode", testUnicode),
        ("testURLEncoded", testURLEncoded),
    ]
}

extension UtilsTests {
    static let __allTests = [
        ("testDouble", testDouble),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ChunkedStreamTests.__allTests),
        testCase(HeaderNameTests.__allTests),
        testCase(HeadersAuthorizationTests.__allTests),
        testCase(NginxTests.__allTests),
        testCase(PunycodeTests.__allTests),
        testCase(RequestDecodeBodyTests.__allTests),
        testCase(RequestDecodeTests.__allTests),
        testCase(RequestEncodeBodyTests.__allTests),
        testCase(RequestEncodeTests.__allTests),
        testCase(RequestTests.__allTests),
        testCase(ResponseDecodeBodyTests.__allTests),
        testCase(ResponseDecodeTests.__allTests),
        testCase(ResponseEncodeBodyTests.__allTests),
        testCase(ResponseEncodeTests.__allTests),
        testCase(ResponseTests.__allTests),
        testCase(URLTests.__allTests),
        testCase(UtilsTests.__allTests),
    ]
}
#endif

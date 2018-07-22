import XCTest

extension BodyTests {
    static let __allTests = [
        ("testRequestBytes", testRequestBytes),
        ("testRequestString", testRequestString),
        ("testResponseBytes", testResponseBytes),
        ("testResponseString", testResponseString),
    ]
}

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

extension RequestDecodeTests {
    static let __allTests = [
        ("testAcceptCharset", testAcceptCharset),
        ("testAcceptCharsetSpaceSeparator", testAcceptCharsetSpaceSeparator),
        ("testAcceptEncodingHeader", testAcceptEncodingHeader),
        ("testAcceptHeader", testAcceptHeader),
        ("testAcceptLanguageHeader", testAcceptLanguageHeader),
        ("testAuthorization", testAuthorization),
        ("testBodyChunked", testBodyChunked),
        ("testBodyChunkedInvalidBody", testBodyChunkedInvalidBody),
        ("testBodyChunkedInvalidSizeSeparator", testBodyChunkedInvalidSizeSeparator),
        ("testBodyChunkedMissingLineEnd", testBodyChunkedMissingLineEnd),
        ("testBodyChunkedNoSizeSeparator", testBodyChunkedNoSizeSeparator),
        ("testBodyContentLength", testBodyContentLength),
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

extension RequestEncodeTests {
    static let __allTests = [
        ("testAccept", testAccept),
        ("testAcceptCharset", testAcceptCharset),
        ("testAcceptEncoding", testAcceptEncoding),
        ("testAcceptLanguage", testAcceptLanguage),
        ("testAuthorization", testAuthorization),
        ("testBodyFormURLEncodedInitializer", testBodyFormURLEncodedInitializer),
        ("testBodyJsonInitializer", testBodyJsonInitializer),
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

extension ResponseDecodeTests {
    static let __allTests = [
        ("testBad", testBad),
        ("testBodyBytesResponse", testBodyBytesResponse),
        ("testBodyChunked", testBodyChunked),
        ("testBodyHtmlResponse", testBodyHtmlResponse),
        ("testBodyJsonResponse", testBodyJsonResponse),
        ("testBodyStringResponse", testBodyStringResponse),
        ("testBodyZeroContentLenght", testBodyZeroContentLenght),
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

extension ResponseEncodeTests {
    static let __allTests = [
        ("testBad", testBad),
        ("testBodyBytesResponse", testBodyBytesResponse),
        ("testBodyHtmlResponse", testBodyHtmlResponse),
        ("testBodyJsonResponse", testBodyJsonResponse),
        ("testBodyStringResponse", testBodyStringResponse),
        ("testBodyUrlFormEncodedResponse", testBodyUrlFormEncodedResponse),
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
        ("testBytes", testBytes),
        ("testContentType", testContentType),
        ("testDefaultStatus", testDefaultStatus),
        ("testHTML", testHTML),
        ("testJavaScript", testJavaScript),
        ("testResponse", testResponse),
        ("testString", testString),
        ("testXML", testXML),
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
        testCase(BodyTests.__allTests),
        testCase(ChunkedStreamTests.__allTests),
        testCase(HeaderNameTests.__allTests),
        testCase(HeadersAuthorizationTests.__allTests),
        testCase(NginxTests.__allTests),
        testCase(PunycodeTests.__allTests),
        testCase(RequestDecodeTests.__allTests),
        testCase(RequestEncodeTests.__allTests),
        testCase(RequestTests.__allTests),
        testCase(ResponseDecodeTests.__allTests),
        testCase(ResponseEncodeTests.__allTests),
        testCase(ResponseTests.__allTests),
        testCase(URLTests.__allTests),
        testCase(UtilsTests.__allTests),
    ]
}
#endif

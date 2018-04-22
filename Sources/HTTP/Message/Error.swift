/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************
 *  This file contains code that has not yet been described                   *
 ******************************************************************************/

public enum Error: Swift.Error {
    case notFound
    case conflict
    case internalServerError
}

public enum ParseError: Swift.Error {
    case invalidRequest
    case invalidResponse
    case invalidStartLine
    case invalidURL
    case invalidMethod
    case invalidStatus
    case invalidVersion
    case invalidHeaderName
    case invalidHost
    case invalidPort
    case invalidAcceptHeader
    case invalidAcceptLanguageHeader
    case invalidAcceptCharsetHeader
    case invalidAuthorizationHeader
    case invalidContentTypeHeader
    case invalidContentEncodingHeader
    case invalidTransferEncodingHeader
    case invalidMediaTypeHeader
    case invalidBoundary
    case invalidCookieHeader
    case invalidSetCookieHeader
    case invalidLanguageHeader
    case unsupportedMediaType
    case unsupportedContentType
    case unsupportedAcceptCharset
    case unsupportedAuthorization
    case unsupportedExpect
    case unexpectedEnd
}

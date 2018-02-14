/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

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

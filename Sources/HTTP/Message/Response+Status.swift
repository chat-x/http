/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

extension Response {
    public enum Status: Equatable {
        // 1xx
        case `continue`
        case switchingProtocols
        case processing
        case earlyHints
        // 2xx
        case ok
        case created
        case accepted
        case nonAuthoritativeInformation
        case noContent
        case resetContent
        case partialContent
        case multiStatus
        case alreadyReported
        case imUsed
        // 3xx
        case multipleChoices
        case moved
        case found
        case seeOther
        case notModified
        case useProxy
        case switchProxy
        case temporaryRedirect
        case permanentRedirect
        // 4xx
        case badRequest
        case unauthorized
        case paymentRequired
        case forbidden
        case notFound
        case methodNotAllowed
        case notAcceptable
        case proxyAuthenticationRequired
        case requestTimeout
        case conflict
        case gone
        case lengthRequired
        case preconditionFailed
        case payloadTooLarge
        case uriTooLong
        case unsupportedMediaType
        case rangeNotSatisfiable
        case expectationFailed
        case iAmATeapot
        case misdirectedRequest
        case unprocessableEntity
        case locked
        case failedDependency
        case upgradeRequired
        case preconditionRequired
        case tooManyRequests
        case requestHeaderFieldsTooLarge
        case unavailableForLegalReasons
        // 5xx
        case internalServerError
        case notImplemented
        case badGateway
        case serviceUnavailable
        case gatewayTimeout
        case httpVersionNotSupported
        case variantAlsoNegotiates
        case insufficientStorage
        case loopDetected
        case notExtended
        case networkAuthenticationRequired
        // custom
        case custom(Int, String)
    }
}

/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import Log

public protocol Middleware {
    static func chain(with handler: @escaping RequestHandler) -> RequestHandler
}

public struct LogMiddleware: Middleware {
    public static func chain(
        with handler: @escaping RequestHandler
    ) -> RequestHandler {
        return { request in
            Log.debug(">> \(request.url.path)")
            let response = try handler(request)
            Log.debug("<< \(response.status)")
            return response
        }
    }
}

public struct ErrorHandlerMiddleware: Middleware {
    public static func chain(
        with handler: @escaping RequestHandler
    ) -> RequestHandler {
        return { request in
            do {
                return try handler(request)
            } catch {
                switch error {
                case let error as HTTP.Error:
                    switch error {
                    case .notFound:
                        Log.warning("not found: \(request.url.path)")
                        return Response(status: .notFound)
                    case .conflict:
                        return Response(status: .conflict)
                    case .internalServerError:
                        return Response(status: .internalServerError)
                    }
                default:
                    throw error
                }
            }
        }
    }
}

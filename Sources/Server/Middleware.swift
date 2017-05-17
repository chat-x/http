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
    static func createMiddleware(
        for handler: @escaping Server.RequestHandler
    ) -> Server.RequestHandler
}

public struct LogMiddleware: Middleware {
    public static func createMiddleware(
        for handler: @escaping Server.RequestHandler
    ) -> Server.RequestHandler {
        return { request in
            Log.debug(">> \(request.url.path)")
            let response = try handler(request)
            Log.debug("<< \(response.status)")
            return response
        }
    }
}

/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

public class Application: RouterProtocol {
    public struct Route {
        public let methods: Router.MethodSet
        public let url: String
        public let middleware: [Middleware.Type]
        public let handler: RequestHandler
    }

    public let basePath: String
    public let middleware: [Middleware.Type]

    public private(set) var routes = [Route]()

    public init(basePath: String = "", middleware: [Middleware.Type] = []) {
        self.basePath = basePath
        self.middleware = middleware
    }

    public func registerRoute(
        methods: Router.MethodSet,
        url: String,
        middleware: [Middleware.Type],
        handler: @escaping RequestHandler
    ) {
        routes.append(Route(
            methods: methods,
            url: self.basePath + url,
            middleware: self.middleware + middleware,
            handler: handler
        ))
    }
}

extension RouterProtocol {
    public mutating func addApplication(_ application: Application) {
        for route in application.routes {
            self.route(
                methods: route.methods,
                url: route.url,
                middleware: route.middleware,
                handler: route.handler)
        }
    }
}

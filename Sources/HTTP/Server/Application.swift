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
        public let path: String
        public let methods: Router.MethodSet
        public let handler: RequestHandler
    }

    public let basePath: String
    public var middleware: [Middleware.Type]

    public private(set) var routes = [Route]()

    public init(basePath: String = "", middleware: [Middleware.Type] = []) {
        self.basePath = basePath
        self.middleware = middleware
    }

    public func registerRoute(
        path: String,
        methods: Router.MethodSet,
        middleware: [Middleware.Type],
        handler: @escaping RequestHandler
    ) {
        let middleware = self.middleware + middleware
        let handler = chainMiddleware(middleware, with: handler)
        routes.append(Route(
            path: self.basePath + path,
            methods: methods,
            handler: handler
        ))
    }

    public func findHandler(
        path: String,
        methods: Router.MethodSet
    ) -> RequestHandler? {
        guard let route = routes.first(where: { route in
            return route.path == path && route.methods.contains(methods)
        }) else {
            return nil
        }
        return route.handler
    }
}

extension RouterProtocol {
    public func addApplication(_ application: Application) {
        for route in application.routes {
            self.registerRoute(
                path: route.path,
                methods: route.methods,
                middleware: [],
                handler: route.handler)
        }
    }
}

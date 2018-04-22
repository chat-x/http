/******************************************************************************
 *                                                                            *
 * Tris Foundation disclaims copyright to this source code.                   *
 * In place of a legal notice, here is a blessing:                            *
 *                                                                            *
 *     May you do good and not evil.                                          *
 *     May you find forgiveness for yourself and forgive others.              *
 *     May you share freely, never taking more than you give.                 *
 *                                                                            *
 ******************************************************************************/
extension Server: RouterProtocol {
    public var middleware: [Middleware.Type] {
        get {
            return router.middleware
        }
        set {
            router.middleware = newValue
        }
    }

    public func registerRoute(
        path: String,
        methods: Router.MethodSet,
        middleware: [Middleware.Type],
        handler: @escaping RequestHandler
    ) {
        router.registerRoute(
            path: path,
            methods: methods,
            middleware: middleware,
            handler: handler)
    }
}

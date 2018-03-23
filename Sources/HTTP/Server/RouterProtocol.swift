/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

// We want the same '.route' APIs for Server and Application
// but while Server registers it directly in the Router
// Application needs to store them until it get passed to the Server

public protocol RouterProtocol: class {
    var middleware: [Middleware.Type] { get set }

    func registerRoute(
        path: String,
        methods: Router.MethodSet,
        middleware: [Middleware.Type],
        handler: @escaping RequestHandler
    )
}
